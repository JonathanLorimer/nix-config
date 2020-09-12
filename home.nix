{ config, pkgs, lib, ... }:

let
  start-sway = pkgs.writeShellScriptBin "start-sway" ''
    # first import environment variables from the login manager
    systemctl --user import-environment
    # then start the service
    exec systemctl --user start sway.service
  '';
  colours = import ./nord.nix { inherit lib; };
  modifier = "Mod4";
in {
  programs.sway.enable = true;

  users.users.jonathanl = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
    shell = pkgs.zsh;
  };
  fonts.fonts = with pkgs; [
    (nerdfonts.override { fonts = ["Iosevka"]; })
  ];
  home-manager.users.jonathanl = {
    imports = [ ./modules/waybar.nix ];
    home.packages = with pkgs; [
      xwayland
      waybar
      sway
      mako
      kanshi
      rofi
      wl-clipboard
      wf-recorder
      start-sway
      bemenu
      alacritty
      pfetch
      neofetch
      starship
      nix-prefetch-git
      nodejs
      ripgrep
      ranger
      bat
      grim

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
          background_opacity = .8;
          selection.save_to_clipboard = true;
          cursor.style = "Block";
          cursor.unfocused_hollow = true;
          url.launcher.program = "chromium";
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
        plugins = with pkgs.vimPlugins; [
          # General
          vim-markdown
          fzfWrapper
          fzf-vim
          vim-rooter
          ranger-vim
          bclose-vim
          vim-airline
          vim-airline-themes
          vim-surround
          vim-commentary
          syntastic
          vim-which-key
          tagbar
          nord-vim

          # Git
          vim-fugitive
          vim-signify
          vim-rhubarb
          gv-vim

          # LSP
          coc-nvim

          # Nix
          vim-nix

          # Haskell
          haskell-vim

          # Typescript
          typescript-vim
          vim-tsx
        ];
      };
      git = {
        enable = true;
        userName = "Jonathan Lorimer";
        userEmail = "jonathan_lorimer@mac.com";
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
          ll = "ls -l";
          "l." = "ls -lah";
          cfghome = "nvim $HOME/.config/nixpkgs/home.nix";
          cfgnix = "nvim $HOME/.config/nixpkgs";
          "nix-src" = "sudo nixos-rebuild switch";
          "home-src" = "sudo home-manager switch";
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
          character.symbol = "λ";
        };
      };
      htop.enable = true;
      chromium.enable = true;
      rofi.enable = true;
    };

    services = {
      waybar = {
        enable = true;
        settings = builtins.toJSON [{
          layer = "bottom";
          position = "top";
          height = 40;
          modules-left = [ "sway/workspaces" "sway/mode" ];
          modules-center = [ "sway/window" ];
          modules-right = [ "clock" "battery" ];
          "sway/window" = {
            format = "{}";
            max-length = 50;
          };
           "sway/mode" = {
            format = "{}";
          };
          clock = {
            format = "{:%H:%M}";
            tooltip-format = "{:%Y-%m-%d | %H:%M}";
            format-alt = "{:%Y-%m-%d}";
          };
        }];
        style = ''
          * {
            border: none;
            border-radius: 0;
            font-family: 'Iosevka';
            font-size: 20px;
            min-height: 0;
          }
          window#waybar {
            background: ${colours.background};
            border-bottom: 3px solid ${colours.colour8};
            color: ${colours.foreground};
          }
          window#waybar.hidden {
            opacity: 0.0;
          }
          #workspaces button {
            padding: 0 5px;
            background: transparent;
            color: ${colours.foreground};
            border-bottom: 3px solid transparent;
          }
          #workspaces button.focused {
            background: ${colours.colour8};
            border-bottom: 3px solid ${colours.background};
          }
          #workspaces button.urgent {
            background-color: ${colours.colour9};
          }
          #clock, #cpu, #memory, #temperature, #backlight, #network, #pulseaudio, #mode, #idle_inhibitor {
            padding: 0 10px;
            margin: 0 5px;
          }
        '';
      };
    };
    wayland.windowManager.sway = {
      enable = true;
      config = {
        fonts = [ "Iosevka" ];
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
          "${modifier}+t" = "exec alacritty";
          "${modifier}+b" = "exec chromium";
          "${modifier}+q" = "kill";
          "${modifier}+n" = "exec makoctl dismiss";
          "${modifier}+w" = "exec rofi  --show run | xargs swaymsg exec --";
          "${modifier}+f" = "fullscreen";

					# Workspace Commands
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
        ];
      };
    };
  };
}
