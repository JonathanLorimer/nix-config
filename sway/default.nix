{ pkgs, nord }:
let
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
in
{
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
        bg = "${../backgrounds/MercuryNordTheme.png} fill";
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
      "${modifier}+Escape" = "exec swaylock ${swaylock-config}";
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
}

