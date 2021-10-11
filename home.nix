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
  start-waybar = pkgs.writeShellScriptBin "start-waybar" "exec systemctl --user restart waybar.service";
  nord = import ./nord.nix;
  vimPluginsOverrides = import ./programs/nvim/plugins.nix {
    buildVimPlugin = pkgs.vimUtils.buildVimPlugin;
    inherit (pkgs) fetchFromGitHub;
  };
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
  waybar-config = import ./modules/waybar/config.nix;
in {
    imports = [./modules/waybar/waybar.nix];
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
      start-waybar

    ];
    home.sessionVariables = {
      EDITOR = "nvim";
      TERMINAL = "alacritty";
    };

    systemd.user.sockets.dbus = {
      Unit = { Description = "D-Bus User Message Bus Socket"; };
      Socket = {
        ListenStream = "%t/bus";
        ExecStartPost = "${pkgs.systemd}/bin/systemctl --user set-environment DBUS_SESSION_BUS_ADDRESS=unix:path=%t/bus";
      };
      Install = {
        WantedBy = [ "sockets.target" ];
        Also = [ "dbus.service" ];
      };
    };

    # I think mako requires dbus?
    systemd.user.services = {
      dbus = {
        Unit = {
          Description = "D-Bus User Message Bus";
          Requires = [ "dbus.socket" ];
        };
        Service = {
          ExecStart = "${pkgs.dbus}/bin/dbus-daemon --session --address=systemd: --nofork --nopidfile --systemd-activation";
          ExecReload = "${pkgs.dbus}/bin/dbus-send --print-reply --session --type=method_call --dest=org.freedesktop.DBus / org.freedesktop.DBus.ReloadConfig";
        };
        Install = {
          Also = [ "dbus.socket" ];
        };
      };
      # sway = {
      #   Unit = {
      #     Description = "Sway - Wayland window manager";
      #     Documentation = [ "man:sway(5)" ];
      #     BindsTo = [ "graphical-session.target" ];
      #     Wants = [ "graphical-session-pre.target" ];
      #     After = [ "graphical-session-pre.target" ];
      #   };
      #   Service = {
      #     Type = "simple";
      #     ExecStart = "${pkgs.sway}/bin/sway";
      #     Restart = "on-failure";
      #     RestartSec = 1;
      #     TimeoutStopSec = 10;
      #   };
      # };
      # kanshi = {
      #   Unit = {
      #     Description = "Kanshi dynamic display configuration";
      #     PartOf = [ "graphical-session.target" ];
      #   };
      #   Install = {
      #     WantedBy = [ "graphical-session.target" ];
      #   };
      #   Service = {
      #     Type = "simple";
      #     ExecStart = "${pkgs.kanshi}/bin/kanshi";
      #     RestartSec = 5;
      #     Restart = "always";
      #   };
      # };
    };

    # xdg.configFile = {
    #   "kanshi/config".text = ''
    #     {
    #       output eDP-1 mode 1920x1080 position 0,0
    #     }
    #   '';
    # };

    programs = {
      alacritty = {
        enable = true;
        settings = {
          shell = {
            program = "${pkgs.zsh}/bin/zsh";
            args = [ "-c"
              "echo; neofetch; echo; zsh"
            ];
          };
          env.TERM = "alacritty";
          env.EDITOR = "nvim";
          window = {
            padding.x = 4;
            padding.y = 4;
            gtk_theme_variant = "Dark";
          };
          scrolling.history = 10000;
          font.normal = {
            family = "PragmataPro Mono";
            style = "Regular";
          };
          font.bold = {
            family = "PragmataPro Mono";
            style = "Bold";
          };
          font.italic = {
            family = "PragmataPro Mono";
            style = "Italic";
          };
          font.bold_italic = {
            family = "PragmataPro Mono";
            style = "Bold Italic";
          };
          font.size = 13.0;
          colors = {
            primary.background = nord.background;
            primary.foreground = nord.foreground;
            cursor.text = nord.cursorText;
            cursor.cursor = nord.cursor;
            normal = {
              black = nord.colour0;
              red = nord.colour1;
              green = nord.colour2;
              yellow = nord.colour3;
              blue = nord.colour4;
              magenta = nord.colour5;
              cyan = nord.colour6;
              white = nord.colour7;
            };
            bright = {
              black = nord.colour8;
              red = nord.colour9;
              green = nord.colour10;
              yellow = nord.colour11;
              blue = nord.colour12;
              magenta = nord.colour13;
              cyan = nord.colour14;
              white = nord.colour15;
            };
          };
          background_opacity = 0.8;
          selection.save_to_clipboard = true;
          cursor.style = "Block";
          cursor.unfocused_hollow = true;
          url.launcher.program = "brave";
        };
      };
      mako = {
        enable = true;
        anchor = "top-right";
        backgroundColor = nord.background;
        textColor = nord.foreground;
        borderColor = nord.colour8;
        borderRadius = 5;
        borderSize = 2;
        font = "PragmataPro Mono 18";
      };
      neovim = {
        enable = true;
        extraConfig = builtins.readFile ./programs/nvim/init.vim;
        plugins = with pkgs.vimPlugins // vimPluginsOverrides ; [
          # General
          syntastic
          kommentary
          goyo-vim
          vim-grammarous
          { # Description: helps determine the root of the project
            plugin = vim-rooter;
            config = ''
              let g:rooter_patterns = ['Makefile', 'package.yaml', 'package.json', '.git', 'src']
            '';
          }
          vim-surround
          vim-vsnip
          vim-vsnip-integ

          # Navigation
          nvim-tree-lua
          telescope-nvim
          plenary-nvim    # required by telescope
          popup-nvim      # required by telescope

          # Search
          { # Description: disables search highlighting when done, re-enables it
            # when you go back to searching.
            plugin = vim-cool;
            config = ''
              let g:CoolTotalMatches = 1
            '';
          }
          { plugin = vim-sneak;
            config = ''
              let g:sneak#label=1
              highlight Sneak guifg=#ECEFF4 guibg=#D08770 ctermfg=Black ctermbg=DarkRed
              highlight SneakScope guifg=#D08770 guibg=#EBCB8B ctermfg=DarkRed ctermbg=Yellow
            '';
          }

          # Themeing
          vim-airline
          vim-airline-themes
          nord-vim
          nvim-web-devicons
          nvim-colorizer

          # Git
          vim-fugitive
          vim-signify

          # LSP
          nvim-lspconfig
          { plugin = completion-nvim;
            config = ''
              let g:completion_enable_snippet = 'vim-vsnip'
              let g:completion_chain_complete_list = [
                  \{'complete_items': ['lsp', 'snippet']},
                  \{'complete_items':  ['path'], 'triggered_only': ['/']},
                  \{'complete_items': ['buffers']},
                  \{'mode': '<c-p>'},
                  \{'mode': '<c-n>'}
              \]
              let g:completion_items_priority = {
                  \'Function': 7,
                  \'Snippet': 5,
                  \'vim-vsnip': 5,
                  \'File': 2,
                  \'Folder': 1,
                  \'Path': 1,
                  \'Buffers': 0
              \}
            '';
          }
          completion-buffers

          # Language Support
          dhall-vim
          purescript-vim
          vim-markdown
          vim-nix
          haskell-vim
          yesod-routes
          idris2-vim
          typescript-vim
          vim-tsx
        ];
      };
      git = {
        enable = true;
        userName = "Jonathan Lorimer";
        userEmail = "jonathan_lorimer@mac.com";
        extraConfig = {
          init.defaultBranch = "main";
          pull.rebase = true;
          merge = {
            tool = "vimdiff";
            conflictstyle = "diff3";
            prompt = false;
            keepBackup = false;
          };
          mergetool = {
            keepBackup = false;
          };
          "mergetool \"vimdiff\"" = {
            cmd = "nvim -d $BASE $LOCAL $REMOTE $MERGED -c '$wincmd w' -c 'wincmd J'";
            keepBackup = false;
          };
        };
        delta = {
          enable = true;
          options = {
            line-numbers = true;
            side-by-side = true;
            syntax-theme = "Nord";
          };
        };
      };
      ssh = {
        enable = true;
        extraConfig = ''
          Host *
            User jonathanl
            IdentityFile ~/.ssh/id_rsa
            AddKeysToAgent yes
        '';
      };
      gpg = {
        enable = true;
      };
      direnv = {
        enable = true;
        enableZshIntegration = true;
      };
      zsh = {
        enable = true;
        dotDir = ".config/zsh";
        enableAutosuggestions = true;
        enableCompletion = true;
        shellAliases = {
          ll = "exa -l";
          l = "exa -lah";
          ls = "exa";
          lt = "exa --long --tree";
          cfg = "nvim $HOME/.config/nixpkgs/home.nix";
          n = "nvim";
          ns = "nvim $(sk)";
          gs = "git status";
          gc = "git commit";
          ga = "git add";
          gp = "git push";
          gr = "git remote add";
        };
        history.expireDuplicatesFirst = true;
        history.ignoreDups = true;
        oh-my-zsh = {
          enable = true;
          plugins = ["git" "sudo" "ssh-agent"];
        };
        # plugins = [];
      };
      skim = {
        enable = true;
        enableZshIntegration = true;
        defaultOptions = [ "--prompt ⟫" "--ansi" "--preview 'bat --color=always {}'" ];
        defaultCommand = "rg --files ";
      };
      starship = {
        enable = true;
        enableZshIntegration = true;
        settings = {
          add_newline = false;
          character.success_symbol = "[λ](bold green)";
          character.error_symbol = "[](bold red)";
          git_branch.symbol = " ";
        };
      };
      htop.enable = true;
      bat = {
        enable = true;
        config.theme = "Nord";
      };
      tmux = {
        enable = true;
        baseIndex = 1;
        historyLimit = 5000;
        plugins = with pkgs.tmuxPlugins; [
          cpu
          battery
          pkgs.tmuxPlugins.nord
        ];
        keyMode = "vi";
        shortcut = "a";
        terminal = "alacritty";
        extraConfig = ''
          # speed up nvim normal mode
          set -s escape-time 0
          set -g status-interval 0

          # fix true color
          set-option -ga terminal-overrides ",alacritty:Tc"

          # vim-like pane movement
          bind -r k select-pane -U
          bind -r j select-pane -D
          bind -r h select-pane -L
          bind -r l select-pane -R

          # vim-like window movement
          bind -r H previous-window
          bind -r L next-window

          # better pane splitting
          bind -r v split-window
          bind -r s split-window -h

          bind -T copy-mode    C-c send -X copy-pipe-no-clear "wl-copy"
          bind -T copy-mode-vi C-c send -X copy-pipe-no-clear "wl-copy"

          # styling
          set -g status-bg default
          set -g status-fg white
          set -g status-style fg=white,bg=default

          set -g status-left ${"''"}
          set -g status-right "#[bg=default] #[fg=magenta]#[fg=black]#[bg=magenta]λ #[fg=white]#[bg=brightblack] %a %d %b #[fg=magenta]%R#[fg=brightblack]#[bg=default]"
          set -g status-justify centre
          set -g status-position bottom

          set -g pane-active-border-style bg=default,fg=default
          set -g pane-border-style fg=default

          set -g window-status-current-format "#[fg=cyan]#[fg=black]#[bg=cyan]#I #[bg=brightblack]#[fg=white] #W#[fg=brightblack]#[bg=default] "
          set -g window-status-format "#[fg=magenta]#[fg=black]#[bg=magenta]#I #[bg=brightblack]#[fg=white] #W#[fg=brightblack]#[bg=default] "
        '';
      };
      waybar = {
        enable = true;
        settings = [waybar-config.settings];
        style = waybar-config.styles;
        systemd.enable = true;
      };
    };
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
          "${modifier}+n" = "exec makoctl dismiss";
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
          { command = "exec systemctl --user start waybar.service";
            always = true;
          }
          { command = "exec systemctl --user start kanshi.service";
            always = true;
          }
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
