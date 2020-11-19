{
  settings = {
    layer = "top";
    position = "top";
    height = 21;

    modules-left= [
      "sway/mode"
      "sway/workspaces"
      "custom/arrow9"
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
        "battery"
        "custom/arrow7"
        "clock#date"
        "custom/arrow8"
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
      "max-length"= 70;
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
        "format"= "";
        "tooltip"= false;
    };

  };
  styles = ''
      /* -----------------------------------------------------------------------------
       * Keyframes
       * -------------------------------------------------------------------------- */

      @keyframes blink-warning {
          70% {
              color: @light;
          }

          to {
              color: @light;
              background-color: @warning;
          }
      }

      @keyframes blink-critical {
          70% {
            color: @light;
          }

          to {
              color: @light;
              background-color: @critical;
          }
      }


      /* -----------------------------------------------------------------------------
       * Styles
       * -------------------------------------------------------------------------- */

      /* COLORS */

      /* Nord */
      @define-color light #eceff4;
      @define-color dark #2e3440;
      @define-color warning #ebcb8b;
      @define-color critical #d08770;
      @define-color mode #4c566a;
      @define-color workspaces #5e81ac;
      @define-color workspacesfocused #81a1c1;
      @define-color sound #d8dee9;
      @define-color network #4c566a;
      @define-color memory #88c0d0;
      @define-color cpu #434c5e;
      @define-color temp #d8dee9;
      @define-color layout #5e81ac;
      @define-color battery #88c0d0;
      @define-color date #2e3440;
      @define-color time #eceff4;

      /* Gruvbox */
      /* @define-color light #ebdbb2; */
      /* @define-color dark #282828; */
      /* @define-color warning #fabd2f; */
      /* @define-color critical #cc241d; */
      /* @define-color mode #a89984; */
      /* @define-color workspaces #458588; */
      /* @define-color workspacesfocused #83a598; */
      /* @define-color sound #d3869b; */
      /* @define-color network #b16286; */
      /* @define-color memory #8ec07c; */
      /* @define-color cpu #98971a; */
      /* @define-color temp #b8bb26; */
      /* @define-color layout #689d6a; */
      /* @define-color battery #fabd2f; */
      /* @define-color date #282828; */
      /* @define-color time #ebdbb2; */

      /* Reset all styles */
      * {
          border: none;
          border-radius: 0;
          min-height: 0;
          margin: 0;
          padding: 0;
      }

      /* The whole bar */
      #waybar {
          background: transparent;
          color: @light;
          font-family: Iosevka, xos4 Terminus, FiraCode, Noto Sans;
          font-size: 10pt;
          font-weight: bold;
      }

      /* Each module */
      #battery,
      #clock,
      #cpu,
      #custom-layout,
      #memory,
      #mode,
      #network,
      #pulseaudio,
      #temperature,
      #custom-alsa,
      #tray {
          padding-left: 10px;
          padding-right: 10px;
      }

      /* Each module that should blink */
      #mode,
      #memory,
      #temperature,
      #battery {
          animation-timing-function: linear;
          animation-iteration-count: infinite;
          animation-direction: alternate;
      }

      /* Each critical module */
      #memory.critical,
      #cpu.critical,
      #temperature.critical,
      #battery.critical {
          color: @critical;
      }

      /* Each critical that should blink */
      #mode,
      #memory.critical,
      #temperature.critical,
      #battery.critical.discharging {
          animation-name: blink-critical;
          animation-duration: 2s;
      }

      /* Each warning */
      #network.disconnected,
      #memory.warning,
      #cpu.warning,
      #temperature.warning,
      #battery.warning {
          color: @warning;
      }

      /* Each warning that should blink */
      #battery.warning.discharging {
          animation-name: blink-warning;
          animation-duration: 3s;
      }

      /* And now modules themselves in their respective order */

      #mode { /* Shown current Sway mode (resize etc.) */
        color: @light;
        background: @mode;
      }

      /* Workspaces stuff */
      #workspaces button {
        font-weight: bold; /* Somewhy the bar-wide setting is ignored*/
        padding-left: 5px;
        padding-right: 5px;
        color: @dark;
        background: @workspaces;
      }

      #workspaces button.focused {
          background: @workspacesfocused;
      }

      /*#workspaces button.urgent {
        border-color: #c9545d;
        color: #c9545d;
      }*/

      #window {
        margin-right: 40px;
        margin-left: 40px;
      }

      #custom-alsa {
        background: @sound;
        color: @dark;
      }

      #network {
          background: @network;
          color: @light;
      }

      #memory {
          background: @memory;
          color: @dark;
      }

      #cpu {
          background: @cpu;
          color: @light;
      }

      #temperature {
          background: @temp;
          color: @dark;
      }

      #custom-layout {
          background: @layout;
          color: @light;
      }

      #battery {
          background: @battery;
          color: @dark;
      }

      #tray {
          background: @date;
      }

      #clock.date {
          background: @date;
          color: @light;
      }

      #clock.time {
          background: @time;
          color: @dark;
      }

      #pulseaudio { /* Unsused but kept for those who needs it */
          background: @sound;
          color: @dark
      }

      #pulseaudio.muted {
          /* No styles */
      }

      #custom-arrow1 {
          font-size: 16px;
          color: @sound;
          background: transparent;
      }

      #custom-arrow2 {
          font-size: 16px;
          color: @network;
          background: @sound;
      }

      #custom-arrow3 {
          font-size: 16px;
          color: @memory;
          background: @network;
      }

      #custom-arrow4 {
          font-size: 16px;
          color: @cpu;
          background: @memory;
      }

      #custom-arrow5 {
          font-size: 16px;
          color: @temp;
          background: @cpu;
      }

      #custom-arrow6 {
          font-size: 16px;
          color: @battery;
          background: @temp;
      }

      #custom-arrow7 {
          font-size: 16px;
          color: @date;
          background: @battery;
      }

      #custom-arrow8 {
          font-size: 16px;
          color: @time;
          background: @date;
      }

      #custom-arrow9 {
          font-size: 16px;
          color: @workspaces;
          background: transparent;
      }
  '';
}
