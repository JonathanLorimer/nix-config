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
      ];
    };
  };
}
