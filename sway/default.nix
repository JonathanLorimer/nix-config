{
  pkgs,
  colorscheme,
  default-font,
}: let
  modifier = "Mod4";
in {
  enable = true;
  systemd.enable = true;
  config = {
    fonts = {
      names = [default-font "Iosevka" "Font Awesome 5 Free"];
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
        bg = "${../backgrounds/utagawa-hiroshige.jpg} fill";
      };
    };
    keybindings = {
      # Controls
      "${modifier}+o" = "exec light -U 5.00";
      "${modifier}+Shift+o" = "exec light -S 0.01";
      "${modifier}+p" = "exec light -A 5.00";
      "${modifier}+Shift+p" = "exec light -S 100";
      "${modifier}+Control+l" = "exec light -Ss \"sysfs/leds/tpacpi::kbd_backlight\" 100";
      "${modifier}+Control+k" = "exec light -Ss \"sysfs/leds/tpacpi::kbd_backlight\" 0";

      # Shortcuts
      "${modifier}+t" = "exec alacritty";
      "${modifier}+b" = "exec firefox";
      "${modifier}+q" = "kill";
      "${modifier}+d" = "exec makoctl dismiss";
      "${modifier}+f" = "fullscreen";
      "${modifier}+z" = "exec zotero";
      "${modifier}+m" = "exec bemenu-run -p 'λ' -b --fn \"${default-font}\" --tb=#4c566a --tf=#81a1c1 --fb=#3b4252 --ff=#d8dee9 --nb=#3b4252 --nf=#d8dee9 --ab=#3b4252 --af=#d8dee9 --hb=#4c566a --hf=#ebcb8b --sb=#4c566a --sf=#ebcb8b";
      "${modifier}+Escape" = "exec swaylock -f";
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
      "${modifier}+s" = "split horizontal";

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
      {
        command = "exec dbus-update-activation-environment WAYLAND_DISPLAY";
        always = true;
      }
      {
        command = "exec systemctl --user import-environment WAYLAND_DISPLAY";
        always = true;
      }
    ];
  };
}
