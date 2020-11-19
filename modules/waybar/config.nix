let styles = import ./waybar.css;
in {
    styles = styles;
    layer = "top";
    position = "top";
    height = 21;

    modules-left= [
    	"sway/mode"
      "sway/workspaces"
      "custom/arrow10"
	    "sway/window"
    ];

    #"modules-center"= [
    #    "sway/window"
    #];

    "modules-right"= [
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
        "custom/layout"
        "custom/arrow7"
        "battery"
        "custom/arrow8"
        "tray"
        "clock#date"
        "custom/arrow9"
        "clock#time"
    ];

    ## -------------------------------------------------------------------------
    ## Modules
    ## -------------------------------------------------------------------------

    "battery"= {
        "interval"= 1;
        "states"= {
            "warning"= 30;
            "critical"= 15;
        };
        "format"= " {capacity}%"; ## Icon bolt
        "format-discharging"= "{icon} {capacity}%";
        "format-icons"= [
            "" ## Icon= battery-full
            "" ## Icon= battery-three-quarters
            "" ## Icon= battery-half
            "" ## Icon= battery-quarter
            ""  ## Icon= battery-empty
        ];
        "tooltip"= false;
    };

    "clock#time"= {
        "interval"= 10;
        "format"= "{:%H:%M}";
        "tooltip"= false;
    };

    "clock#date"= {
        "interval"= 20;
        "format"= "{:%e %b %Y}"; ## Icon: calendar-alt
        ##"tooltip-format"= "{:%e %B %Y}"
        "tooltip"= false;
    };

    "cpu"= {
        "interval"= 5;
        "tooltip"= false;
        "format"= " {usage}%"; ## Icon: microchip
        "states"= {
          "warning"= 70;
          "critical"= 90;
        };
    };

    "custom/layout"= {
      ##"exec"= "~/.config/waybar/layout.sh";
      "exec"= "swaymsg --type get_inputs | grep \"xkb_active_layout_name\" | sed -u '1!d; s/^.*xkb_active_layout_name\": \"##; s/ (US)//; s/\";//' && swaymsg --type subscribe --monitor '[\"input\"]' | sed -u 's/^.*xkb_active_layout_name\": \"//; s/\",.*$//; s/ (US)//'";
      ##"interval"= 5;
      "format"= " {}"; ## Icon: keyboard
      ## Signal sent by Sway key binding (~/.config/sway/key-bindings)
      ##"signal"= 1; // SIGHUP
      "tooltip"= false;
    };

    "memory"= {
        "interval"= 5;
        "format"= " {}%"; ## Icon: memory
        "states"= {
            "warning"= 70;
            "critical"= 90;
        };
    };

    "network"= {
        "interval"= 5;
        "format-wifi"= " {essid} ({signalStrength}%)"; ## Icon: wifi
        ##"format-ethernet"= " {ifname}: {ipaddr}/{cidr}"; ## Icon: ethernet
        "format-ethernet"= " {ifname}";
        "format-disconnected"= "Disconnected";
        ##"tooltip-format"= "{ifname}: {ipaddr}";
        "tooltip"= false;
        ##"on-click"= "cmst"
    };

    "sway/mode"= {
        "format"= "<span style=\"italic\"> {}</span>"; ## Icon: expand-arrows-alt
        "tooltip"= false;
    };

    "sway/window"= {
      "format"= "{}";
      "max-length"= 30;
	    "tooltip"= false;
    };

    "sway/workspaces"= {
        "all-outputs"= false;
        "disable-scroll"= false;
        "format"= "{name}";
        "format-icons"= {
            "1=www"= "龜"; ## Icon: firefox-browser
            "2=mail"= ""; ## Icon: mail
            "3=editor"= ""; ## Icon: code
            "4=terminals"= ""; ## Icon: terminal
            "5=portal"= ""; ## Icon: terminal
            "urgent"= "";
            "focused"= "";
            "default"= "";
        };
    };

    "pulseaudio"= {
        "scroll-step"= 1;
        "format"= "{icon} {volume}%";
        "format-bluetooth"= "{icon} {volume}%";
        "format-muted"= "";
        "format-icons"= {
            "headphones"= "";
            "handsfree"= "";
            "headset"= "";
            "phone"= "";
            "portable"= "";
            "car"= "";
            "default"= ["" ""];
        };
        "on-click"= "pavucontrol";
    };

    "temperature"= {
        "critical-threshold"= 90;
        "interval"= 5;
        ##"format"= "{icon} {temperatureC}°C";
	    "format"= "{icon} {temperatureC}°";
        "format-icons"= [
            "" ## Icon= temperature-empty
            "" ## Icon= temperature-quarter
            "" ## Icon= temperature-half
            "" ## Icon= temperature-three-quarters
            "" ## Icon= temperature-full
        ];
        "tooltip"= false;
    };

    "custom/alsa"= {
        "exec"= "amixer get Master | sed -nre 's/.*\\[off\\].*/ muted/p; s/.*\\[(.*%)\\].*/ \\1/p'";
        "on-click"= "amixer set Master toggle; pkill -x -RTMIN+11 waybar";
        "on-scroll-up"= "amixer set Master 1+; pkill -x -RTMIN+11 waybar";
        "on-scroll-down"= "amixer set Master 1-; pkill -x -RTMIN+11 waybar";
        "signal"= 11;
        "interval"= 10;
        "tooltip"= false;
    };

    "tray"= {
        "icon-size"= 21;
        ##"spacing"= 10;
    };

    "custom/arrow1"= {
        "format"= "";
        "tooltip"= false;
    };

    "custom/arrow2"= {
        "format"= "";
        "tooltip"= false;
    };

    "custom/arrow3"= {
        "format"= "";
        "tooltip"= false;
    };

    "custom/arrow4"= {
        "format"= "";
        "tooltip"= false;
    };

    "custom/arrow5"= {
        "format"= "";
        "tooltip"= false;
    };

    "custom/arrow6"= {
        "format"= "";
        "tooltip"= false;
    };

    "custom/arrow7"= {
        "format"= "";
        "tooltip"= false;
    };

    "custom/arrow8"= {
        "format"= "";
        "tooltip"= false;
    };

    "custom/arrow9"= {
        "format"= "";
        "tooltip"= false;
    };

    "custom/arrow10"= {
        "format"= "";
        "tooltip"= false;
    };
}
