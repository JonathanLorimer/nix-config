{ config, pkgs, ... }:
{
  sops.defaultSopsFile = ./sops/secrets.yaml;
  nix = {
    package = pkgs.nixFlakes;
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
    trustedUsers = [ "jonathanl" "root" ];
    binaryCaches = [
      "https://cache.nixos.org"
      "https://cache.mercury.com"
      "https://hydra.iohk.io"
      "https://iohk.cachix.org"
      "https://nixpkgs-wayland.cachix.org"
      "https://shajra.cachix.org"
      "https://nix-community.cachix.org"
      "https://jonathanlorimer.cachix.org"
      "https://pre-commit-hooks.cachix.org"
    ];
    binaryCachePublicKeys = [
      "cache.mercury.com:yhfFlgvqtv0cAxzflJ0aZW3mbulx4+5EOZm6k3oML+I="
      "hydra.iohk.io:f/Ea+s+dFdN+3Y/G+FDgSq+a5NEWhJGzdjvKNGv0/EQ="
      "iohk.cachix.org-1:DpRUyj7h7V830dp/i6Nti+NEO2/nhblbov/8MW7Rqoo="
      "nixpkgs-wayland.cachix.org-1:3lwxaILxMRkVhehr5StQprHdEo4IrE8sRho9R9HOLYA="
      "shajra.cachix.org-1:V0x7Wjgd/mHGk2KQwzXv8iydfIgLupbnZKLSQt5hh9o="
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      "jonathanlorimer.cachix.org-1:SP8thQYURhXnzTx4W5c2hUbpbeWit1WKPv/rQuSyy+Y="
      "pre-commit-hooks.cachix.org-1:Pkk3Panw5AW24TOv6kz3PvLhlH8puAsJTBbOPmBo7Rc="
    ];
   };

  programs = {
    sway.enable = true;
    gnupg.agent = {
      enable = true;
      pinentryFlavor = "curses";
    };
  };

  users.users.jonathanl = {
    isNormalUser = true;
    extraGroups = [ "wheel" "audio" "video" "sway" "networkmanager" ];
    shell = pkgs.zsh;
  };

  fonts.fonts = with pkgs; [
    (nerdfonts.override { fonts = ["Iosevka"]; })
    font-awesome
    pragmata-pro
  ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.kernel.sysctl."fs.inotify.max_user_watches" = "1048576";

  # Networking
  networking.networkmanager.enable = true;
  networking.wireless.iwd.enable = true;
  networking.networkmanager.wifi.backend = "iwd";

  networking.useDHCP = false;
  networking.interfaces.wlan0.useDHCP = false;

  # Set your time zone.
  time.timeZone = "Canada/Eastern";

  # List packages installed in system profile. To search, run:
  environment.systemPackages = [
    pkgs.vim
    pkgs.linuxPackages.v4l2loopback
  ];

  # Nixpkgs
  nixpkgs.config.pulseaudio = true;

  # Enable Light
  programs.light.enable = true;

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Postgres
  services.postgresql = {
    package = pkgs.postgresql_13;
    enable = true;
    enableTCPIP = false;
    authentication = ''
      local all all trust
      host all all 127.0.0.1/32 trust
      host all all ::1/128 trust
    '';
    extraPlugins = [config.services.postgresql.package.pkgs.postgis];
    settings = {
      timezone = "UTC";
      shared_buffers = 128;
      fsync = false;
      synchronous_commit = false;
      full_page_writes = false;
    };
  };

  # Yubikey
  services.udev.packages = [ pkgs.yubikey-personalization ];

  # Enable sound.
  sound.enable = true;
  hardware.bluetooth.enable = true;
  hardware.pulseaudio.enable = true;
  hardware.pulseaudio.package = pkgs.pulseaudioFull;
  hardware.pulseaudio.extraModules = [ pkgs.pulseaudio-modules-bt ];

  # set the correct sound card
  boot.extraModprobeConfig = ''
    options v4l2loopback exclusive_caps=1
    options snd slots=snd_hda_intel
  '';

  boot.kernelModules = [
    "v4l2loopback"
  ];

  boot.extraModulePackages = [
    config.boot.kernelPackages.v4l2loopback
  ];

  boot.blacklistedKernelModules = [ "snd_pcsp" ];

  # System Version
  system.stateVersion = "21.11";

  system.autoUpgrade.enable = true;
  system.autoUpgrade.allowReboot = true;
}

