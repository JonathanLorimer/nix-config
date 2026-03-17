#!/usr/bin/env bash
set -euo pipefail

# NixOS ZFS + LUKS Partition Script for Erymanthian
# Usage: sudo ./partition.sh /dev/nvme0n1

DISK="${1:-}"

if [[ -z "$DISK" ]]; then
    echo "Usage: $0 <disk>"
    echo ""
    echo "Available disks:"
    lsblk -d -o NAME,SIZE,MODEL | grep -v "loop\|sr\|ram"
    echo ""
    echo "Example: $0 /dev/nvme0n1"
    exit 1
fi

if [[ ! -b "$DISK" ]]; then
    echo "Error: $DISK is not a block device"
    exit 1
fi

# Derive partition names (handles both nvme and sda style)
if [[ "$DISK" == *"nvme"* ]]; then
    BOOT_PART="${DISK}p1"
    SWAP_PART="${DISK}p2"
    ROOT_PART="${DISK}p3"
else
    BOOT_PART="${DISK}1"
    SWAP_PART="${DISK}2"
    ROOT_PART="${DISK}3"
fi

CRYPT_NAME="cryptroot"
CRYPT_DEVICE="/dev/mapper/${CRYPT_NAME}"
POOL_NAME="rpool"

echo "============================================"
echo "NixOS ZFS + LUKS Installation Script"
echo "============================================"
echo ""
echo "Target disk: $DISK"
echo "Boot partition: $BOOT_PART (2GB EFI)"
echo "Swap partition: $SWAP_PART (4GB)"
echo "Root partition: $ROOT_PART (LUKS + ZFS)"
echo ""
echo "WARNING: This will DESTROY all data on $DISK"
echo ""
read -p "Type 'yes' to continue: " CONFIRM

if [[ "$CONFIRM" != "yes" ]]; then
    echo "Aborted."
    exit 1
fi

echo ""
echo ">>> Step 1: Partitioning disk..."
parted "$DISK" -- mklabel gpt
parted "$DISK" -- mkpart ESP fat32 1MiB 2GiB
parted "$DISK" -- set 1 esp on
parted "$DISK" -- mkpart primary linux-swap 2GiB 6GiB
parted "$DISK" -- mkpart primary 6GiB 100%

echo ""
echo "--- Partition table:"
parted "$DISK" print

echo ""
echo ">>> Step 2a: Formatting boot partition..."
mkfs.fat -F 32 -n BOOT "$BOOT_PART"

echo ""
echo ">>> Step 2b: Formatting swap partition..."
mkswap -L SWAP "$SWAP_PART"

echo ""
echo "--- Filesystem info:"
lsblk -f "$DISK"

echo ""
echo ">>> Step 3: Setting up LUKS encryption..."
echo "You will be prompted to enter a passphrase for disk encryption (twice for confirmation)."
cryptsetup luksFormat --type luks2 --pbkdf argon2id -s 512 --use-random --verify-passphrase "$ROOT_PART"

echo ""
echo ">>> Step 4: Opening LUKS device..."
cryptsetup luksOpen "$ROOT_PART" "$CRYPT_NAME"

echo ""
echo "--- LUKS device mapped to: $CRYPT_DEVICE"
ls -la "$CRYPT_DEVICE"

echo ""
echo ">>> Step 5: Creating ZFS pool..."
zpool create -f \
    -o ashift=12 \
    -o autotrim=on \
    -O acltype=posixacl \
    -O canmount=off \
    -O compression=zstd \
    -O dnodesize=auto \
    -O normalization=formD \
    -O relatime=on \
    -O xattr=sa \
    -O mountpoint=none \
    "$POOL_NAME" "$CRYPT_DEVICE"

echo ""
echo "--- ZFS pool status:"
zpool status "$POOL_NAME"

echo ""
echo ">>> Step 6: Creating ZFS datasets..."

# Local datasets (not backed up)
zfs create -o mountpoint=none "$POOL_NAME/local"
zfs create -o mountpoint=legacy "$POOL_NAME/local/root"
zfs create -o mountpoint=legacy "$POOL_NAME/local/nix"

# Safe datasets (backed up)
zfs create -o mountpoint=none "$POOL_NAME/safe"
zfs create -o mountpoint=legacy "$POOL_NAME/safe/home"
zfs create -o mountpoint=legacy "$POOL_NAME/safe/persist"

echo ""
echo "--- ZFS datasets:"
zfs list -r "$POOL_NAME"

echo ""
echo ">>> Step 7: Creating blank snapshot for impermanence..."
zfs snapshot "$POOL_NAME/local/root@blank"

echo ""
echo "--- Snapshots:"
zfs list -t snapshot

echo ""
echo ">>> Step 8: Mounting filesystems..."
mount -t zfs "$POOL_NAME/local/root" /mnt

mkdir -p /mnt/{nix,home,persist,boot}

mount -t zfs "$POOL_NAME/local/nix" /mnt/nix
mount -t zfs "$POOL_NAME/safe/home" /mnt/home
mount -t zfs "$POOL_NAME/safe/persist" /mnt/persist
mount "$BOOT_PART" /mnt/boot

echo ""
echo ">>> Step 9: Creating persist directories..."
mkdir -p /mnt/persist/etc/NetworkManager/system-connections
mkdir -p /mnt/persist/var/lib/postgresql
mkdir -p /mnt/persist/var/lib/iwd
mkdir -p /mnt/persist/var/lib/tailscale
mkdir -p /mnt/persist/var/lib/kolide-k2

echo ""
echo "--- Persist directory structure:"
tree -L 3 /mnt/persist || ls -laR /mnt/persist

echo ""
echo "--- Mount overview:"
findmnt --target /mnt --tree

echo ""
echo "============================================"
echo "Partitioning complete!"
echo "============================================"
echo ""
echo "Filesystems mounted at /mnt:"
df -h /mnt /mnt/nix /mnt/home /mnt/persist /mnt/boot
echo ""
echo "Next steps:"
echo "  1. Generate hardware config:"
echo "     nixos-generate-config --root /mnt"
echo ""
echo "  2. Clone your nix-config:"
echo "     git clone <your-repo> /mnt/persist/nix-config"
echo ""
echo "  3. Copy hardware-configuration.nix to your config:"
echo "     cp /mnt/etc/nixos/hardware-configuration.nix /mnt/persist/nix-config/modules/erymanthian/"
echo ""
echo "  4. Get UUIDs for your config:"
echo "     LUKS UUID: $(blkid -s UUID -o value "$ROOT_PART")"
echo "     Boot UUID: $(blkid -s UUID -o value "$BOOT_PART")"
echo ""
echo "  5. Generate hostId:"
echo "     $(head -c4 /dev/urandom | od -A none -t x4 | tr -d ' ')"
echo ""
echo "  6. Install NixOS:"
echo "     nixos-install --flake /mnt/persist/nix-config#erymanthian"
