{
  pkgs,
  scripts,
  env-vars,
  cornelis,
}: {
  pointerCursor = {
    gtk.enable = true;
    package = pkgs.bibata-cursors;
    name = "Bibata-Modern-Ice";
    size = 32;
  };
  packages = with pkgs;
    [
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

      # Messaging
      keybase
      keybase-gui

      # Browser
      firefox-wayland
      chromium

      # Network
      openvpn
      openssl

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
      cornelis
      insomnia
      tree-sitter
      tabnine
      dbeaver-bin

      # LSP
      nodePackages.typescript-language-server
      nodePackages.vscode-langservers-extracted
      nil
      alejandra 
      sumneko-lua-language-server
      # (idris2-pkgs.lsp.withSources (ps: [ ps.comonad ps.contrib ps.test ps.idris2 ]))
      # (idris2-pkgs.idris2.withSources (ps: [ ps.comonad ps.contrib ps.test ps.idris2 ]))

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
      eza
      duf
      tokei
      tealdeer
      hyperfine
      xh
      highlight

      # Knowledge Management
      zotero
    ]
    ++ scripts;

  stateVersion = "22.05";

  sessionVariables =
    {
      RTC_USE_PIPEWIRE = "true";
      MOZ_ENABLE_WAYLAND = "1";
      XDG_CURRENT_DESKTOP = "sway";
      XDG_SESSION_TYPE = "wayland";
    }
    // env-vars;
}
