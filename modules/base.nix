{
  config,
  pkgs,
  ...
}: {
  programs.sway.enable = true;
  programs.zsh.enable = true;

  fonts.packages = with pkgs; [
    (nerdfonts.override {fonts = ["Iosevka"];})
    font-awesome
    pragmata-pro
    pragmata-pro-patched
  ];

  boot.binfmt.emulatedSystems = ["aarch64-linux"];

  # Graphics
  hardware.opengl.enable = true;

  # Use the systemd-boot EFI boot loader.
  boot.loader.grub = {
    gfxmodeEfi = "3440x1440";
    font = "${pkgs.hack-font}/share/fonts/hack/Hack-Regular.ttf";
    fontSize = 36;
  };
  boot.loader.efi.canTouchEfiVariables = true;
  boot.kernel.sysctl = {
    "fs.inotify.max_user_watches" = 1048576; # default:  8192
    "fs.inotify.max_user_instances" = 1024; # default:   128
    "fs.inotify.max_queued_events" = 32768; # default: 16384
  };

  # Networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Canada/Eastern";

  # List packages installed in system profile. To search, run:
  environment.systemPackages = [
    pkgs.vim
    pkgs.linuxPackages.v4l2loopback
  ];

  # Nixpkgs
  nixpkgs.allowUnfreePackages = [
    "discord"
    "vscode"
    "postman"
    "steam-run"
    "steam-original"
    "steam"
    "tabnine"
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

  hardware.keyboard.zsa.enable = true;

  # set the correct sound card
  boot.extraModprobeConfig = ''
    options v4l2loopback exclusive_caps=1
    options snd-hda-intel index=1,0 model=auto,dell-headset-multi
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
