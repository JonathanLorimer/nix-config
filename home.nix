{ config, pkgs, ... }:

let
  start-work = pkgs.writeShellScriptBin "start-work" ''
    SESSION="Work"
    WORK_DIR_BE="~/Mercury/mercury-web-backend"
    WORK_DIR_FE="~/Mercury/mercury-web"

    # Re-connect to vpn
    sudo systemctl restart openvpn-mercury

    # Establish sessions and windows
    tmux new-session -d -s "$SESSION"
    tmux rename-window -t 1 'Editor BE' tmux new-window -t "$SESSION:2" -n 'Shell'
    tmux new-window -t "$SESSION:3" -n 'Server'
    tmux new-window -t "$SESSION:4" -n 'DB'
    tmux new-window -t "$SESSION:5" -n 'Editor FE'

    # Setup Editor
    tmux split-window -h -p 30 -t "$SESSION:Editor BE"
    tmux send-keys -t "$SESSION:Editor BE.1" "cd $WORK_DIR_BE; nix-shell --run 'nvim'" C-m
    tmux send-keys -t "$SESSION:Editor BE.2" "cd $WORK_DIR_BE; nix-shell --run 'make ghcid'" C-m

    tmux split-window -h -p 30 -t "$SESSION:Editor FE"
    tmux send-keys -t "$SESSION:Editor FE.1" "cd $WORK_DIR_FE; nix-shell" C-m
    tmux send-keys -t "$SESSION:Editor FE.2" "cd $WORK_DIR_FE; nix-shell" C-m

    # Setup Editor
    tmux send-keys -t "$SESSION:DB" "sudo su - postgres" C-m

    # Setup Server
    tmux send-keys -t "$SESSION:Server" "ssh -l jonathanl 2.mercury-web-backend.production.internal.mercury.com" C-m

    tmux attach -t "$SESSION:Shell"
  '';
  nord = import ./nord.nix;
  modifier = "Mod4";
  swaylock-config = pkgs.lib.cli.toGNUCommandLineShell {} {
    screenshots = true;
    clock = true;
    indicator = true;
    show-failed-attempts = true;
    ignore-empty-password = true;
    effect-blur = "7x5";
    effect-vignette = "0.6:0.6";
    ring-color = nord.colour4;
    ring-ver-color = nord.colour2;
    ring-wrong-color = nord.colour1;
    key-hl-color = nord.colour3;
    line-color = "00000000";
    line-ver-color = "00000000";
    line-wrong-color = "00000000";
    inside-color = "00000000";
    inside-ver-color = "00000000";
    inside-wrong-color = "00000000";
    separator-color = "00000000";
    text-color = nord.foreground;
  };
  swaylock-command = "swaylock ${swaylock-config}";
in {
    home.packages = with pkgs; [
      pipewire
      xdg-desktop-portal-wlr

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
      awscli
      aws-mfa
      stack
      idris2
      exercism
      vscode
      cachix
      nix-prefetch-git

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

      # Scripts
      start-work
    ];

    home.sessionVariables = {
      EDITOR = "nvim";
      TERMINAL = "alacritty";
    };

    programs = (import ./programs/default.nix) {inherit pkgs nord; };
    services = {
      blueman-applet.enable = true;
      spotifyd.enable = true;
      gpg-agent = {
        enable = true;
        enableSshSupport = true;
      };
      kanshi = {
        enable = true;
        profiles = {
          home.outputs = [
            {
              criteria = "eDP-1";
              mode = "1920x1080";
              position = "0,0";
            }
          ];
        };
      };
    };
    wayland.windowManager.sway = {
      enable = true;
      systemdIntegration = true;
      config = {
        fonts = {
          names = [ "PragmataPro Mono" "Iosevka" "Font Awesome 5 Free" ];
          style = "Bold";
          size = 11.0;
        };
        gaps = {
          inner = 5;
          outer = 5;
        };
        terminal = "alacritty";
        inherit modifier;
        input = {
          "*" = {
            repeat_delay = "200";
            repeat_rate = "35";
            xkb_layout = "us";
            xkb_options = "caps:ctrl_modifier";
          };
        };
        output = {
          "*" = {
            bg = "${./backgrounds/MercuryNordTheme.png} fill";
          };
        };
        keybindings = {
          # Controls
          "${modifier}+Control+o" = "exec amixer set Master 5%-";
          "${modifier}+Control+p" = "exec amixer set Master 5%+";
          "${modifier}+o" = "exec light -U 5.00";
          "${modifier}+p" = "exec light -A 5.00";
          "${modifier}+Control+l" = "exec light -Ss \"sysfs/leds/tpacpi::kbd_backlight\" 100";
          "${modifier}+Control+k" = "exec light -Ss \"sysfs/leds/tpacpi::kbd_backlight\" 0";

          # Shortcuts
          "${modifier}+t" = "exec alacritty";
          "${modifier}+b" = "exec brave";
          "${modifier}+q" = "kill";
          "${modifier}+d" = "exec makoctl dismiss";
          "${modifier}+f" = "fullscreen";
          "${modifier}+z" = "exec zotero";
          "${modifier}+m" = "exec bemenu-run -p 'λ' -b --fn \"PragmataPro Mono\" --tb=#4c566a --tf=#81a1c1 --fb=#3b4252 --ff=#d8dee9 --nb=#3b4252 --nf=#d8dee9 --hb=#4c566a --hf=#ebcb8b --sb=#4c566a --sf=#ebcb8b";
          "${modifier}+Escape" = "exec ${swaylock-command}";
          "${modifier}+g" = "exec grim $(echo $HOME)/Pictures/$(date +'%s_grim.png') -o $(swaymsg -t get_outputs | jq -r '.[] | select(.focused) | .name')";
          "${modifier}+Shift+g" = "exec grim -g \"$(slurp)\" $(echo $HOME)/Pictures/$(date +'%s_grim.png')";

          # Workspace Commands
          "${modifier}+h" = "focus left";
          "${modifier}+Shift+h" = "move left";
          "${modifier}+j" = "focus down";
          "${modifier}+Shift+j" = "focus down";
          "${modifier}+k" = "focus up";
          "${modifier}+Shift+k" = "move up";
          "${modifier}+l" = "focus right";
          "${modifier}+Shift+l" = "move right";

          "${modifier}+Shift+s" = "split vertical";
          "${modifier}+s"       = "split horizontal";

          "${modifier}+1" = "workspace number 1";
          "${modifier}+2" = "workspace number 2";
          "${modifier}+3" = "workspace number 3";
          "${modifier}+4" = "workspace number 4";
          "${modifier}+5" = "workspace number 5";
          "${modifier}+6" = "workspace number 6";
          "${modifier}+7" = "workspace number 7";
          "${modifier}+8" = "workspace number 8";
          "${modifier}+9" = "workspace number 9";

          "${modifier}+Shift+1" = "move container to workspace number 1, workspace number 1";
          "${modifier}+Shift+2" = "move container to workspace number 2, workspace number 2";
          "${modifier}+Shift+3" = "move container to workspace number 3, workspace number 3";
          "${modifier}+Shift+4" = "move container to workspace number 4, workspace number 4";
          "${modifier}+Shift+5" = "move container to workspace number 5, workspace number 5";
          "${modifier}+Shift+6" = "move container to workspace number 6, workspace number 6";
          "${modifier}+Shift+7" = "move container to workspace number 7, workspace number 7";
          "${modifier}+Shift+8" = "move container to workspace number 8, workspace number 8";
          "${modifier}+Shift+9" = "move container to workspace number 9, workspace number 9";
        };
        workspaceAutoBackAndForth = true;
        bars = [];
        startup = [
          # { command = ''
          #     swayidle -w \
          #       timeout 300 '${swaylock-command}' \
          #       timeout 600 'swaymsg "output * dpms off"' \
          #             resume 'swaymsg "output * dpms on"' \
          #   '';
          #   always = false;
          # }
        ];
      };
    };
}
