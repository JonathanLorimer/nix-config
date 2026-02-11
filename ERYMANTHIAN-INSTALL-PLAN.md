# Erymanthian Installation Plan

## Overview

This plan sets up a new NixOS installation on a ThinkPad P16 Gen 2 using:
- **ZFS** with "erase your darlings" pattern (ephemeral root)
- **LUKS encryption** for full disk encryption
- **Impermanence** via ZFS snapshot rollback on each boot

## Architecture

### Disk Layout (UEFI + LUKS + ZFS)

```
/dev/nvme0n1 (or your disk)
├── p1: EFI System Partition (2GB, FAT32) → /boot
└── p2: LUKS encrypted partition (rest of disk)
    └── /dev/mapper/cryptroot
        └── ZFS pool: rpool
            ├── local/root   → /         (ephemeral, rolled back on boot)
            ├── local/nix    → /nix      (persistent, nix store)
            ├── safe/home    → /home     (persistent, user data)
            └── safe/persist → /persist  (persistent, system state)
```

### Persistence Strategy

State that must survive reboots:
- `/persist/etc/NetworkManager/system-connections/` - WiFi passwords
- `/persist/var/lib/postgresql/` - Database data
- `/persist/var/lib/iwd/` - IWD state (if using)
- `/persist/var/lib/tailscale/` - Tailscale state
- `/persist/var/lib/kolide-k2/` - Kolide state

---

## Phase 1: Prepare Custom Installation ISO

### Enhanced `image.nix`

The current `image.nix` is minimal and missing ZFS support. We'll enhance it to:
- Add ZFS kernel support
- Include useful tools (git, vim, parted, cryptsetup)
- Bundle the partition script
- Include this flake for quick deployment

### Build Command

```bash
nix build .#nixosConfigurations.installer.config.system.build.isoImage
# Result: result/iso/nixos-*.iso
```

---

## Phase 2: Partition Script

A script (`install/partition.sh`) that automates:

1. **Partition the disk** (GPT table)
   - 2GB EFI partition (type ef00) - generous size for many NixOS generations
   - Rest as Linux partition for LUKS

2. **Setup LUKS encryption**
   - Uses argon2id KDF (better than argon2i)
   - 512-bit key size
   - You'll be prompted for passphrase

3. **Create ZFS pool**
   - `ashift=12` for 4K sectors
   - `compression=zstd` (better than lz4)
   - `acltype=posixacl` for proper ACL support
   - `xattr=sa` for extended attributes
   - `normalization=formD` for unicode normalization

4. **Create datasets**
   - `rpool/local/root` with `@blank` snapshot
   - `rpool/local/nix`
   - `rpool/safe/home`
   - `rpool/safe/persist`

5. **Create blank snapshot** for rollback
   - `zfs snapshot rpool/local/root@blank`

6. **Mount everything to `/mnt`**
   ```bash
   # Mount root first
   mount -t zfs rpool/local/root /mnt

   # Create mount points
   mkdir -p /mnt/{nix,home,persist,boot}

   # Mount other ZFS datasets
   mount -t zfs rpool/local/nix /mnt/nix
   mount -t zfs rpool/safe/home /mnt/home
   mount -t zfs rpool/safe/persist /mnt/persist

   # Mount boot partition
   mount /dev/nvme0n1p1 /mnt/boot
   ```

### Usage

```bash
# After booting the ISO:
sudo ./partition.sh /dev/nvme0n1
```

---

## Phase 3: Configuration Files

### Directory Structure

```
modules/erymanthian/
├── hardware-configuration.nix  # Auto-generated after partitioning
├── encryption.nix              # LUKS device config
├── host.nix                    # Network identity
├── impermanence.nix            # Rollback + bind mounts
├── nix.nix                     # Build settings
├── state-version.nix           # NixOS version
└── users.nix                   # User accounts
```

### Files to Create

#### `modules/erymanthian/host.nix`
```nix
{
  networking.hostId = "????????";  # Generate with: head -c4 /dev/urandom | od -A none -t x4 | tr -d ' '
  networking.hostName = "erymanthian";
}
```

#### `modules/erymanthian/encryption.nix`
```nix
{
  boot.loader.grub = {
    enable = true;
    device = "nodev";
    efiSupport = true;
    enableCryptodisk = true;
  };
  boot.initrd.luks.devices = {
    root = {
      device = "/dev/disk/by-uuid/XXXXXXXX-XXXX-XXXX-XXXX-XXXXXXXXXXXX";  # LUKS partition UUID
      preLVM = true;
    };
  };
}
```

#### `modules/erymanthian/impermanence.nix`
```nix
{lib, ...}: {
  boot.supportedFilesystems = ["zfs"];
  boot.initrd.postDeviceCommands = lib.mkAfter ''
    zfs rollback -r rpool/local/root@blank
  '';

  environment.etc."NetworkManager/system-connections" = {
    source = "/persist/etc/NetworkManager/system-connections/";
  };

  fileSystems = {
    "/var/lib/postgresql" = {
      device = "/persist/var/lib/postgresql";
      options = ["bind"];
    };
    "/var/lib/iwd" = {
      device = "/persist/var/lib/iwd";
      options = ["bind"];
    };
    "/var/lib/kolide-k2" = {
      device = "/persist/var/lib/kolide-k2";
      options = ["bind"];
    };
  };

  systemd.services.tailscaled.serviceConfig.BindPaths = "/persist/var/lib/tailscale:/var/lib/tailscale";
}
```

#### `modules/erymanthian/nix.nix`
```nix
{pkgs, ...}: {
  # P16 Gen 2 has many cores - adjust based on your CPU
  nix.settings.max-jobs = pkgs.lib.mkDefault 16;
}
```

#### `modules/erymanthian/state-version.nix`
```nix
{
  # Fresh install - use current NixOS version
  # Verify with: nix-instantiate --eval -E '(import <nixpkgs> {}).lib.version'
  system.stateVersion = "25.11";
}
```

#### `modules/erymanthian/users.nix`

**Important:** Generate the hashed password on daedalus *before* installing:

```bash
# Generate a SHA-512 hashed password (you'll be prompted to enter it)
mkpasswd -m sha-512
```

Then use that hash in the config:

```nix
{pkgs, ...}: {
  users = {
    users.root = {
      hashedPassword = "$6$...";  # Paste your generated hash here
    };
    users.jonathanl = {
      isNormalUser = true;
      createHome = true;
      hashedPassword = "$6$...";  # Same hash (or different if you prefer)
      extraGroups = ["wheel" "audio" "video" "sway" "networkmanager" "plugdev"];
      home = "/home/jonathanl";
      shell = pkgs.zsh;
    };
  };
  programs.zsh.enable = true;
}
```

**Tip:** You can reuse the same hash from daedalus if you want the same password - just copy it from `modules/daedalus/users.nix`.

### Flake Update

Add to `nixosConfigurations` in `flake.nix`:
```nix
erymanthian = nixpkgs.lib.nixosSystem {
  inherit system;
  modules =
    (commonModules "erymanthian")
    ++ [
      ./modules/erymanthian/hardware-configuration.nix
      ./modules/erymanthian/nix.nix
      ./modules/erymanthian/encryption.nix
      ./modules/erymanthian/host.nix
      ./modules/erymanthian/impermanence.nix
      ./modules/erymanthian/users.nix
      ./modules/erymanthian/state-version.nix

      # Hardware - generic ThinkPad (P16 Gen 2 not in nixos-hardware yet)
      nixos-hardware.nixosModules.lenovo-thinkpad
      nixpkgs.nixosModules.notDetected

      # Kolide for Mercury
      kolide.nixosModules.kolide-launcher
      {
        nixpkgs.allowUnfreePackages = ["kolide-launcher"];
        services.kolide-launcher.enable = true;
        environment.etc."kolide-k2/secret" = {
          mode = "0600";
          text = "eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCJ9...";  # Your Kolide token
        };
      }
    ];
};
```

---

## Phase 4: Installation Steps

### On Current Machine (daedalus)

1. **Create the files** (we'll do this together)
2. **Build the ISO**:
   ```bash
   nix build .#nixosConfigurations.installer.config.system.build.isoImage
   ```
3. **Flash to USB**:
   ```bash
   sudo dd if=result/iso/nixos-*.iso of=/dev/sdX bs=4M status=progress
   ```

### On New Machine (erymanthian)

1. **Boot from USB** (may need to disable Secure Boot)

2. **Connect to WiFi** (if needed):
   ```bash
   sudo systemctl start wpa_supplicant
   wpa_cli
   > add_network
   > set_network 0 ssid "YourSSID"
   > set_network 0 psk "YourPassword"
   > enable_network 0
   ```

3. **Run partition script**:
   ```bash
   sudo ./partition.sh /dev/nvme0n1
   ```

4. **Generate hardware config**:
   ```bash
   nixos-generate-config --root /mnt
   # Copy the generated hardware-configuration.nix to your repo
   ```

5. **Clone your config** (or copy from USB):
   ```bash
   git clone https://github.com/your/nix-config /mnt/persist/nix-config
   # Or copy from USB if no network
   ```

6. **Update UUIDs**:
   - Get LUKS partition UUID: `blkid /dev/nvme0n1p2`
   - Get boot partition UUID: `blkid /dev/nvme0n1p1`
   - Update `encryption.nix` and `hardware-configuration.nix`

7. **Generate hostId**:
   ```bash
   head -c4 /dev/urandom | od -A none -t x4 | tr -d ' '
   ```

8. **Install NixOS**:
   ```bash
   nixos-install --flake /mnt/persist/nix-config#erymanthian
   ```
   You'll be prompted for a root password - this is a **safety net** in case
   the hashedPassword in your config has issues. Enter a password you'll remember.

9. **Create persist directories**:
   ```bash
   mkdir -p /mnt/persist/etc/NetworkManager/system-connections
   mkdir -p /mnt/persist/var/lib/postgresql
   mkdir -p /mnt/persist/var/lib/iwd
   mkdir -p /mnt/persist/var/lib/tailscale
   mkdir -p /mnt/persist/var/lib/kolide-k2
   ```

10. **Reboot**:
    ```bash
    reboot
    ```

---

## Post-Installation

1. **First boot** - You'll be prompted for LUKS passphrase
2. **Login** as jonathanl (or set root password first)
3. **Connect to WiFi** - NetworkManager should be available
4. **Setup Tailscale**: `sudo tailscale up`
5. **Verify impermanence** - After another reboot, `/` should be clean

---

## Validation Checklist

- [ ] System boots and prompts for LUKS passphrase
- [ ] ZFS pools mount correctly
- [ ] Root filesystem is ephemeral (check with `zfs diff rpool/local/root@blank`)
- [ ] /home persists across reboots
- [ ] WiFi connections persist
- [ ] Tailscale state persists
- [ ] PostgreSQL data persists (if used)

---

## Next Steps

Ready to implement? We'll create:
1. Enhanced `image.nix` with ZFS support
2. `install/partition.sh` script
3. `modules/erymanthian/` directory with all config files
4. Update `flake.nix`

Let me know if you want to proceed or have questions about the plan!
