{
  enable = true;
  style = builtins.readFile ./waybar-nord.css;
  systemd.enable = true;
  systemd.target = "sway-session.target";
  settings = [
    {
      layer = "top";
      position = "top";
      height = 26;

      modules-left = [
        "sway/workspaces"
      ];

      modules-center = ["sway/window"];

      modules-right = [
        "network"
        "battery"
        "clock#date"
        "clock#time"
      ];

      battery = {
        interval = 1;
        states = {
          warning = 30;
          critical = 10;
        };
        format = "↑{capacity}%";
        format-discharging = "{capacity}%";
        format-discharging-warning = "*{capacity}%";
        format-discharging-critical = "!{capacity}%";
        tooltip = false;
      };

      "clock#time" = {
        interval = 10;
        format = "{:%H:%M}";
        tooltip = false;
      };

      "clock#date" = {
        interval = 20;
        format = "{:%e %b %Y}"; ## Icon: calendar-alt
        tooltip = false;
      };

      network = {
        interval = 1;
        format-wifi = "●"; ## Icon: wifi
        format-ethernet = "●";
        format-disconnected = "⭘";
        tooltip-format = "{essid}:{ifname}:{ipaddr}";
        tooltip = true;
      };

      "sway/window" = {
        format = "{}";
        max-length = 70;
        tooltip = false;
      };

      "sway/workspaces" = {
        format = "{}";
      };
    }
  ];
}
