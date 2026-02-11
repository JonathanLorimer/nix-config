{
  pkgs,
  modulesPath,
  lib,
  ...
}: {
  imports = [
    "${modulesPath}/installer/cd-dvd/installation-cd-minimal.nix"
  ];

  # Use stable kernel - latest often breaks ZFS
  boot.kernelPackages = pkgs.linuxPackages_6_18;

  boot.supportedFilesystems = lib.mkForce ["btrfs" "reiserfs" "vfat" "f2fs" "xfs" "ntfs" "cifs" "zfs"];

  # Include partition script in the ISO
  environment.etc."partition.sh" = {
    source = ./install/partition.sh;
    mode = "0755";
  };

  environment.systemPackages = with pkgs; [
    # Partitioning and filesystem tools
    parted
    gptfdisk
    cryptsetup
    zfs

    # Editors
    vim
    helix

    # Version control and networking
    git
    curl
    wget
    dhcpcd

    # Useful utilities
    tmux
    htop
    tree
  ];

  # Set a simple root password for the live environment
  users.users.root.initialHashedPassword = lib.mkForce null;
  users.users.root.initialPassword = "nixos";

  # Include Intel WiFi and other firmware
  hardware.enableRedistributableFirmware = true;

  # Networking for WiFi
  networking.wireless.enable = true;

  environment.loginShellInit = ''
    echo ""
    echo "ZFS + LUKS partition script: /etc/partition.sh"
    echo ""
    echo "Available disks:"
    lsblk -d -o NAME,SIZE,MODEL | grep -v "loop\|sr\|ram"
    echo ""
    echo "Usage: bash /etc/partition.sh /dev/<disk>"
    echo ""
  '';
}
