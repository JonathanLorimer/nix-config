{
  config,
  pkgs,
  ...
}: {
  programs.sway.enable = true;
  programs.zsh.enable = true;

  users.users.jonathanl = {
    isNormalUser = true;
    extraGroups = ["wheel" "audio" "video" "sway" "networkmanager" "plugdev"];
    shell = pkgs.zsh;
  };

  fonts.packages = with pkgs; [
    (nerdfonts.override {fonts = ["Iosevka"];})
    font-awesome
    pragmata-pro
    pragmata-pro-patched
  ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.kernel.sysctl = {
      "fs.inotify.max_user_watches"   = 1048576;   # default:  8192
      "fs.inotify.max_user_instances" =    1024;   # default:   128
      "fs.inotify.max_queued_events"  =   32768;   # default: 16384
    };

  # Networking
  networking.networkmanager.enable = true;
  networking.wireless.iwd.enable = true;
  networking.networkmanager.wifi.backend = "iwd";
  # See https://github.com/NixOS/nixpkgs/issues/180175
  systemd.services.NetworkManager-wait-online = {  
    serviceConfig = {
      ExecStart = [ "" "${pkgs.networkmanager}/bin/nm-online -q" ];
    };
  };
  # systemd.services.systemd-networkd-wait-online.enable = pkgs.lib.mkForce false;

  networking.useDHCP = false;
  networking.interfaces.wlan0.useDHCP = true;

  # Set your time zone.
  time.timeZone = "Canada/Eastern";

  # List packages installed in system profile. To search, run:
  environment.systemPackages = [
    pkgs.vim
    pkgs.linuxPackages.v4l2loopback
  ];

  # Nixpkgs
  nixpkgs.config.allowUnfreePredicate = pkg:
    builtins.elem (pkgs.lib.getName pkg) [
      "discord"
      "obsidian"
      "vscode"
      "postman"
      "steam-run"
      "steam-original"
      "steam"
    ];

  # Enable Light
  programs.light.enable = true;

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Yubikey
  services.udev.packages = [pkgs.yubikey-personalization];

  # Enable sound.
  sound.enable = true;
  hardware.bluetooth.enable = true;
  # hardware.pulseaudio.enable = true;
  # hardware.pulseaudio.package = pkgs.pulseaudioFull;

  hardware.keyboard.zsa.enable = true;

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

  boot.blacklistedKernelModules = ["snd_pcsp"];

  # System Version
  system.stateVersion = "22.05";

  system.autoUpgrade.enable = true;
  system.autoUpgrade.allowReboot = true;
}
