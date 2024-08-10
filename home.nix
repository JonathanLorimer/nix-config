{
  pkgs,
  env-vars,
  cornelis,
  impala,
}: {
  pointerCursor = {
    gtk.enable = true;
    package = pkgs.bibata-cursors;
    name = "Bibata-Modern-Ice";
    size = 32;
  };
  packages = with pkgs; [
    # Wayland
    xwayland

    # Sway Utils
    slurp
    wl-clipboard
    wf-recorder
    grim

    # Video
    vlc
    ffmpeg
    kooha

    # Browser
    firefox-wayland
    chromium

    # Network
    openssl
    impala

    # Sound
    pw-volume
    pavucontrol
    pulseaudio

    # Navigation
    bemenu

    # Programming
    agda
    cornelis
    gcc
    awscli
    aws-mfa
    stack
    exercism
    cachix
    nix-prefetch-git
    gh
    insomnia
    tree-sitter
    dbeaver-bin

    # LSP
    nodePackages.typescript-language-server
    nodePackages.vscode-langservers-extracted
    nil
    alejandra

    # Terminal
    neofetch
    asciinema

    # Command Line Utils
    jq
    ruplacer
    duf
    tokei

    # Knowledge Management
    zotero
  ];

  stateVersion = "24.11";

  sessionVariables =
    {
      RTC_USE_PIPEWIRE = "true";
      MOZ_ENABLE_WAYLAND = "1";
      XDG_CURRENT_DESKTOP = "sway";
      XDG_SESSION_TYPE = "wayland";
    }
    // env-vars;
}
