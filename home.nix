{ pkgs }:
{
  packages = with pkgs; [
    # Wayland
    xwayland
    swaylock-effects

    # Sway Utils
    slurp
    wl-clipboard
    wf-recorder
    grim

    # Messaging
    keybase
    keybase-gui

    # Network
    openvpn
    openssl

    # Sound
    pavucontrol
    spotify-tui

    # Navigation
    bemenu

    # Browsers
    firefox-wayland
    brave

    # Programming
    gcc
    awscli
    aws-mfa
    stack
    idris2
    exercism
    vscode
    cachix
    nix-prefetch-git
    gh

    # LSP
    nodePackages.typescript-language-server
    rnix-lsp
    haskell-language-server

    # Terminal
    alacritty
    neofetch
    asciinema
    rlwrap
    tmate

    # Command Line Utils
    jq
    ripgrep
    ruplacer
    exa
    duf
    tokei
    tealdeer
    hyperfine
    xh
    highlight

    # Knowledge Management
    obsidian
    zotero

  ] ++ ((import ./scripts) {inherit pkgs;});

  sessionVariables = {
    EDITOR = "nvim";
    TERMINAL = "alacritty";
    RTC_USE_PIPEWIRE = "true";
    MOZ_ENABLE_WAYLAND = "1";
    XDG_CURRENT_DESKTOP = "sway";
    XDG_SESSION_TYPE = "wayland";
    CODE_DIR = "$HOME/Code";
    WORK_DIR = "$HOME/Mercury";
  };
}
