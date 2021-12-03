{
  blueman-applet.enable = true;
  spotifyd.enable = true;
  gpg-agent = {
    enable = true;
    enableSshSupport = true;
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
