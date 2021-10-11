{
  settings = {
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

    ## -------------------------------------------------------------------------
    ## Modules
    ## -------------------------------------------------------------------------
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
      @define-color workspaces #5e81ac;
      @define-color workspacesfocused #81a1c1;
      @define-color arrow #5e81ac;
      @define-color sound #4c566a;
      @define-color network #4c566a;
      @define-color memory #434c5e;
      @define-color cpu #434c5e;
      @define-color temp #3B4252;
      @define-color battery #3B4252;
      @define-color date #2e3440;
      @define-color time #2e3440;

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
      #network,
      #pulseaudio,
      #temperature,
      #custom-alsa,
      #tray {
          padding-left: 10px;
          padding-right: 10px;
      }

      /* Each module that should blink */
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
        color: @light;
      }

      #network {
          background: @network;
          color: @light;
      }

      #memory {
          background: @memory;
          color: @light;
      }

      #cpu {
          background: @cpu;
          color: @light;
      }

      #temperature {
          background: @temp;
          color: @light;
      }

      #custom-layout {
          background: @layout;
          color: @light;
      }

      #battery {
          background: @battery;
          color: @light;
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
          color: @light;
      }

      #custom-arrow1 {
          font-size: 16px;
          color: @sound;
          background: transparent;
      }

      #custom-arrow2 {
          font-size: 16px;
          color: @arrow;
          background: @sound;
      }

      #custom-arrow3 {
          font-size: 16px;
          color: @memory;
          background: @network;
      }

      #custom-arrow4 {
          font-size: 16px;
          color: @arrow;
          background: @memory;
      }

      #custom-arrow5 {
          font-size: 16px;
          color: @temp;
          background: @cpu;
      }

      #custom-arrow6 {
          font-size: 16px;
          color: @arrow;
          background: @temp;
      }

      #custom-arrow7 {
          font-size: 16px;
          color: @date;
          background: @battery;
      }

      #custom-arrow8 {
          font-size: 16px;
          color: @arrow;
          background: @date;
      }

      #custom-arrow9 {
          font-size: 16px;
          color: @workspaces;
          background: transparent;
      }
  '';
}
