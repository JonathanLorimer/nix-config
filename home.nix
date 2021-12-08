{ pkgs, scripts, env-vars}:
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
    agda
    gcc
    awscli
    aws-mfa
    stack
    idris2
    exercism
    cachix
    nix-prefetch-git
    gh

    # LSP
    nodePackages.typescript-language-server
    rnix-lsp
    haskell-language-server
    idris2-pkgs.lsp

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

  ] ++ scripts;

  sessionVariables = {
    RTC_USE_PIPEWIRE = "true";
    MOZ_ENABLE_WAYLAND = "1";
    XDG_CURRENT_DESKTOP = "sway";
    XDG_SESSION_TYPE = "wayland";
  } // env-vars;
}
