{ config, pkgs, lib, ... }:

let
  start-sway = pkgs.writeShellScriptBin "start-sway" ''
    # first import environment variables from the login manager
    systemctl --user import-environment
    # then start the service
    exec systemctl --user start sway.service
  '';
  colours = import ./nord.nix { inherit lib; };
  vimPluginsOverrides = import ./programs/nvim/plugins.nix {
    buildVimPlugin = pkgs.vimUtils.buildVimPlugin;
    inherit (pkgs) fetchFromGitHub;
  };
  modifier = "Mod4";
  swaylock-effects = pkgs.callPackage ./programs/swaylock-effects.nix {};
  swaylock-config = lib.cli.toGNUCommandLineShell {} {
    screenshots = true;
    clock = true;
    indicator = true;
    show-failed-attempts = true;
    ignore-empty-password = true;
    effect-blur = "7x5";
    effect-vignette = "0.6:0.6";
    ring-color = colours.colour4;
    ring-ver-color = colours.colour2;
    ring-wrong-color = colours.colour1;
    key-hl-color = colours.colour3;
    line-color = "00000000";
    line-ver-color = "00000000";
    line-wrong-color = "00000000";
    inside-color = "00000000";
    inside-ver-color = "00000000";
    inside-wrong-color = "00000000";
    separator-color = "00000000";
    text-color = colours.foreground;
  };
  swaylock-command = "swaylock ${swaylock-config}";
  waybar-config = import ./modules/waybar/config.nix;
in {
    imports = [./modules/waybar/waybar.nix];
    home.packages = with pkgs; [
      # Wayland
      xwayland
      waybar
      sway
      start-sway
      swaylock-effects

      # Messaging
      keybase
      keybase-gui

      # Network
      wireshark-cli
      termshark
      openvpn
      openssl

      # Display
      kanshi

      # Sound
      pavucontrol

      # Video
      vlc

      # Notifications
      mako

      # Navigation
      bemenu

      # Browsers
      firefox-wayland
      brave

      # Accounting
      hledger

      # Security

      # Programming
      ctags
      haskellPackages.hasktags
      nodePackages.typescript-language-server
      rnix-lsp
      haskell-language-server
      stack
      idris2
      exercism
      pgcli
      nodejs
      yarn

      # Terminal
      alacritty
      neofetch
      asciinema
      rlwrap

      # Utils
      ripgrep
      ruplacer
      ranger
      grim
      wl-clipboard
      wf-recorder
      nix-prefetch-git
      exa
      procs
      tokei
      bandwhich
      highlight

      # Knowledge Management
      obsidian
      zotero
      zathura
      tectonic
      texlive.combined.scheme-full
      elementary-planner

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
      sway = {
        Unit = {
          Description = "Sway - Wayland window manager";
          Documentation = [ "man:sway(5)" ];
          BindsTo = [ "graphical-session.target" ];
          Wants = [ "graphical-session-pre.target" ];
          After = [ "graphical-session-pre.target" ];
        };
        Service = {
          Type = "simple";
          ExecStart = "${pkgs.sway}/bin/sway";
          Restart = "on-failure";
          RestartSec = 1;
          TimeoutStopSec = 10;
        };
      };
      kanshi = {
        Unit = {
          Description = "Kanshi dynamic display configuration";
          PartOf = [ "graphical-session.target" ];
        };
        Install = {
          WantBy = [ "graphical-session.target" ];
        };
        Service = {
          Type = "simple";
          ExecStart = "${pkgs.kanshi}/bin/kanshi";
          RestartSec = 5;
          Restart = "always";
        };
      };
    };

    xdg.configFile."kanshi/config".text = ''
      {
        output eDP-1 mode 1920x1080 position 0,0
      }
    '';

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
            family = "Iosevka";
            style = "Medium";
          };
          font.bold = {
            family = "Iosevka";
            style = "Heavy";
          };
          font.italic = {
            family = "Iosevka";
            style = "Italic";
          };
          font.bold_italic = {
            family = "Iosevka";
            style = "Heavy Italic";
          };
          font.size = 13.0;
          colors = {
            primary.background = colours.background;
            primary.foreground = colours.foreground;
            cursor.text = colours.cursorText;
            cursor.cursor = colours.cursor;
            normal = {
              black = colours.colour0;
              red = colours.colour1;
              green = colours.colour2;
              yellow = colours.colour3;
              blue = colours.colour4;
              magenta = colours.colour5;
              cyan = colours.colour6;
              white = colours.colour7;
            };
            bright = {
              black = colours.colour8;
              red = colours.colour9;
              green = colours.colour10;
              yellow = colours.colour11;
              blue = colours.colour12;
              magenta = colours.colour13;
              cyan = colours.colour14;
              white = colours.colour15;
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
        backgroundColor = colours.background;
        textColor = colours.foreground;
        borderColor = colours.colour8;
        borderRadius = 5;
        borderSize = 2;
        font = "Iosevka 18";
      };
      neovim = {
        enable = true;
        extraConfig = builtins.readFile ./programs/nvim/init.vim;
        plugins = with pkgs.vimPlugins // vimPluginsOverrides ; [
          # General
          syntastic
          tagbar
          vim-commentary
          vim-rooter
          vim-surround

          # Navigation
          ranger-vim
          bclose-vim
          fzfWrapper
          fzf-vim

          # Search
          { plugin = vim-cool;
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

          # Git
          vim-fugitive
          vim-signify
          vim-rhubarb
          gv-vim

          # Language Support
          nvim-lspconfig
          completion-nvim
          nvim-treesitter
          vim-markdown
          { plugin = vimtex;
            config = ''
              let g:tex_flavor='latex'
              let g:vimtex_view_method='zathura'
              let g:vimtex_quickfix_mode=0
              set conceallevel=1
              let g:tex_conceal='abdmg'
            '';
          }
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
          pull.rebase = true;
          merge = {
            tool = "vimdiff";
            conflictstyle = "diff3";
            prompt = false;
            keepBackup = false;
          };
          "mergetool \"vimdiff\"" = {
            cmd = "nvim -d $BASE $LOCAL $REMOTE $MERGED -c '$wincmd w' -c 'wincmd J'";
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
            AddKeysToAgent yes
            User jonathanl
            IdentityFile ~/.ssh/id_rsa
        '';
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
          cfghome = "nvim $HOME/.config/nixpkgs/home.nix";
          cfgnix = "nvim $HOME/.config/nixpkgs";
          "nrs" = "sudo nixos-rebuild switch";
          "hs" = "sudo home-manager switch";
        };
        history.expireDuplicatesFirst = true;
        history.ignoreDups = true;
        oh-my-zsh = {
          enable = true;
          plugins = ["git" "sudo"];
        };
      };
      fzf = {
        enable = true;
        enableZshIntegration = true;
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
      rofi.enable = true;
      bat = {
        enable = true;
        config.theme = "Nord";
      };
    };
    services = {

      waybar = {
        enable = true;
        settings = builtins.toJSON waybar-config.settings;
        style = waybar-config.styles;
      };
    };
    wayland.windowManager.sway = {
      enable = true;
      config = {
        fonts = [ "Iosevka" "Font Awesome 5 Free" ];
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
            xkb_options = "caps:escape";
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
          "${modifier}+m" = "exec bemenu-run -p 'λ' -b --fn Iosevka --tb=#4c566a --tf=#81a1c1 --fb=#3b4252 --ff=#d8dee9 --nb=#3b4252 --nf=#d8dee9 --hb=#4c566a --hf=#ebcb8b --sb=#4c566a --sf=#ebcb8b";
          "${modifier}+Escape" = "exec ${swaylock-command}";

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
          { command = "exec systemctl --user restart waybar.service";
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
