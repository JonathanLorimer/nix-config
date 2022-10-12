{
  spotifyd.enable = true;
  gpg-agent = {
    enable = true;
    enableSshSupport = true;
    enableZshIntegration = true;
    defaultCacheTtl = 5 * 60;
    pinentryFlavor = "tty";
    verbose = true;
  };
  swayidle = {
    enable = true;
    timeouts = [
      { timeout = 300;
        command = "swaylock -f";
      }
      { timeout = 600;
        command = "swaymsg 'output * dpms off'";
        resumeCommand = "swaymsg 'output * dpms on'";
      }
    ];
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
        {
          criteria = "HDMI-A-1";
          mode = "3440x1440";
          position = "1920,0";
        }
      ];
    };
  };
}
