{
  config,
  pkgs,
  ...
}: {
  programs.sway.enable = true;
  programs.zsh.enable = true;

  fonts.packages = with pkgs; [
    font-awesome
    pragmata-pro
  ];

  boot.binfmt.emulatedSystems = ["aarch64-linux"];

  # Graphics
  hardware.graphics.enable = true;

  # Use the systemd-boot EFI boot loader.
  boot.loader.grub = {
    enable = true;
    device = "nodev";
    efiSupport = true;
    font = "${pkgs.pragmata-pro-console}/share/fonts/consolefont/pragmatapro/ppr32.pf2";
    fontSize = 32;
  };
  boot.loader.efi.canTouchEfiVariables = true;
  boot.kernel.sysctl = {
    "fs.inotify.max_user_watches" = 1048576; # default:  8192
    "fs.inotify.max_user_instances" = 1024; # default:   128
    "fs.inotify.max_queued_events" = 32768; # default: 16384
  };

  # Networking
  networking.firewall.enable = false;
  networking.interfaces.wlan0.useDHCP = true;
  networking.wireless.iwd = {
    enable = true;
    settings = {
      General.UseDefaultInterface = false;
      Settings = {
        AutoConnect = true;
      };
    };
  };

  # Set your time zone.
  time.timeZone = "Canada/Eastern";

  # List packages installed in system profile. To search, run:
  environment.systemPackages = [
    pkgs.vim
    pkgs.linuxPackages.v4l2loopback
  ];

  environment.pathsToLink = ["/share/zsh"];

  # Nixpkgs
  nixpkgs.allowUnfreePackages = [
    "slack"
    "discord"
    "vscode"
    "postman"
    "steam-run"
    "steam-original"
    "steam"
    "steam-unwrapped"
    "tabnine"
    "onepassword-password-manager"
  ];

  # Enable Light
  programs.light.enable = true;

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Yubikey
  services.udev.packages = [pkgs.yubikey-personalization];

  # Enable sound.
  hardware.bluetooth.enable = true;

  hardware.keyboard.zsa.enable = true;

  # set the correct sound card
  boot.extraModprobeConfig = ''
    options v4l2loopback exclusive_caps=1
    options snd-hda-intel model=dell-headset-multi
  '';

  boot.kernelModules = [
    "v4l2loopback"
  ];

  boot.extraModulePackages = [
    config.boot.kernelPackages.v4l2loopback
  ];

  boot.blacklistedKernelModules = ["snd_pcsp"];

  # System Version
  system.stateVersion = "24.11";

  nixpkgs.config.permittedInsecurePackages = [
    "electron-25.9.0"
  ];
}
