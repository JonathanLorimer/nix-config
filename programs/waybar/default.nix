{
  enable = true;
  style = builtins.readFile ./waybar-nord.css;
  systemd.enable = true;
  systemd.target = "sway-session.target";
  settings = [
    {
      layer = "top";
      position = "top";
      height = 21;

      modules-left= [
        "sway/workspaces"
        "custom/arrow9"
        "sway/window"
      ];

      modules-right= [
        "custom/arrow1"
        "custom/alsa"
        "custom/arrow2"
        "network"
        "custom/arrow3"
        "memory"
        "custom/arrow4"
        "cpu"
        "custom/arrow5"
        "temperature"
        "custom/arrow6"
        "battery"
        "custom/arrow7"
        "clock#date"
        "custom/arrow8"
        "clock#time"
      ];

      modules = {
        battery = {
          interval = 1;
          states = {
            warning = 30;
            critical = 15;
          };
          format = " {capacity}%"; ## Icon bolt
          format-discharging = "{icon} {capacity}%";
          format-icons = [
            "" ## Icon= battery-full
            "" ## Icon= battery-three-quarters
            "" ## Icon= battery-half
            "" ## Icon= battery-quarter
            ""  ## Icon= battery-empty
          ];
          tooltip= false;
        };

        "clock#time"= {
          interval = 10;
          format = "{:%H:%M}";
          tooltip = false;
        };

        "clock#date" = {
          interval = 20;
          format = "{:%e %b %Y}"; ## Icon: calendar-alt
          tooltip = false;
        };

        cpu = {
          interval = 5;
          tooltip = false;
          format = " {usage}%"; ## Icon: microchip
          states = {
            warning = 70;
            critical = 90;
          };
        };

        memory= {
          interval = 5;
          format = " {}%"; ## Icon: memory
          states = {
            warning = 70;
            critical = 90;
          };
        };

        network = {
          interval = 1;
          format-wifi = " {essid} ({signalStrength}%)"; ## Icon: wifi
          format-ethernet = " {ifname}";
          format-disconnected = "Disconnected";
          tooltip-format = "{ifname}: {ipaddr}";
          tooltip = true;
        };

        "sway/window"= {
          format = "{}";
          max-length = 70;
          tooltip = false;
        };

        temperature= {
          critical-threshold = 90;
          interval = 5;
          format = "{icon} {temperatureC}°";
          format-icons = [
            "" ## Icon= temperature-empty
            "" ## Icon= temperature-quarter
            "" ## Icon= temperature-half
            "" ## Icon= temperature-three-quarters
            "" ## Icon= temperature-full
          ];
          tooltip = false;
        };

        "custom/alsa" = {
          exec = "amixer get Master | sed -nre 's/.*\\[off\\].*/ muted/p; s/.*\\[(.*%)\\].*/ \\1/p'";
          on-click = "amixer set Master toggle; pkill -x -RTMIN+11 waybar";
          on-scroll-up = "amixer set Master 1+; pkill -x -RTMIN+11 waybar";
          on-scroll-down = "amixer set Master 1-; pkill -x -RTMIN+11 waybar";
          signal = 11;
          interval = 10;
          tooltip = false;
        };

        "custom/arrow1" = {
          format = "";
          tooltip = false;
        };

        "custom/arrow2" = {
          format = "";
          tooltip = false;
        };

        "custom/arrow3" = {
          format = "";
          tooltip = false;
        };

        "custom/arrow4" = {
          format = "";
          tooltip = false;
        };

        "custom/arrow5" = {
          format = "";
          tooltip = false;
        };

        "custom/arrow6" = {
          format = "";
          tooltip = false;
        };

        "custom/arrow7" = {
          format = "";
          tooltip = false;
        };

        "custom/arrow8" = {
          format = "";
          tooltip = false;
        };

        "custom/arrow9" = {
          format = "";
          tooltip = false;
        };
      };
    }
  ];
}
