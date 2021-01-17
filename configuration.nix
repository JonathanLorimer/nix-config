# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:
let secrets = import /home/jonathanl/.config/nixpkgs/secrets.nix;
in {
  imports =
    [ # Include the results of the hardware scan.
      "${builtins.fetchGit { url = "https://github.com/NixOS/nixos-hardware.git"; }}/lenovo/thinkpad/x1/7th-gen"
      <home-manager/nixos>
      /etc/nixos/hardware-configuration.nix
      /home/jonathanl/.config/nixpkgs/home.nix
      /home/jonathanl/.config/nixpkgs/vpn/default.nix
    ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.kernel.sysctl."fs.inotify.max_user_watches" = "1048576";

  # Networking
  networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  networking.useDHCP = false;
  networking.interfaces.wlp0s20f3.useDHCP = true;
  networking.wireless.networks = {
    "deCrom-5G" = {
      psk = secrets.network.deCrom-5G;
    };
    deCrom = {
      psk = secrets.network.deCrom;
    };
    "Lorne-5G" = {
      psk = secrets.network.Lorne-5G;
    };
    "House" = {
      psk = secrets.network.House;
    };
  };

  # Set your time zone.
  time.timeZone = "Canada/Eastern";

  # List packages installed in system profile. To search, run:
  environment.systemPackages = [
    pkgs.vim
  ];

  # Nixpkgs
  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.pulseaudio = true;

  # Enable Light
  programs.light.enable = true;

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Nix Configuration
  nix = {
    trustedUsers = [ "jonathanl" "root" ];
    binaryCaches = [ "https://cache.nixos.org" "https://cache.mercury.com" ];
    binaryCachePublicKeys = [ "cache.mercury.com:yhfFlgvqtv0cAxzflJ0aZW3mbulx4+5EOZm6k3oML+I=" ];
  };

  # Postgres
  services.postgresql = {
    package = pkgs.postgresql_12;
    enable = true;
    enableTCPIP = false;
    authentication = ''
      local all all trust
      host all all 127.0.0.1/32 trust
      host all all ::1/128 trust
    '';
    settings = {
      timezone = "UTC";
      shared_buffers = 128;
      fsync = false;
      synchronous_commit = false;
      full_page_writes = false;
    };
  };

  # Enable sound.
  sound.enable = true;
  hardware.bluetooth.enable = true;
  hardware.pulseaudio.enable = true;
  hardware.pulseaudio.package = pkgs.pulseaudioFull;
  hardware.pulseaudio.extraModules = [ pkgs.pulseaudio-modules-bt ];

  # set the correct sound card
  boot.extraModprobeConfig = ''
    options snd slots=snd_hda_intel
  '';

  boot.blacklistedKernelModules = [ "snd_pcsp" ];

  # System Version
  system.stateVersion = "20.09";

  system.autoUpgrade.enable = true;
  system.autoUpgrade.allowReboot = true;
}

