{configurationName}: let
  configurationProfiles = {
    bellerophon = [
      {
        profile.name = "mobile";
        proifle.outputs = [
          {
            criteria = "eDP-1";
            mode = "1920x1080";
            position = "0,0";
          }
        ];
      }
      {
        profile.name = "workstation";
        profile.outputs = [
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
      }
    ];
    daedalus = [
      {
        profile.name = "mobile";
        profile.outputs = [
          {
            criteria = "eDP-1";
            mode = "3840x2160@60.000Hz";
            position = "0,0";
            scale = 2.0;
          }
        ];
      }
      {
        profile.name = "workstation";
        profile.outputs = [
          {
            criteria = "eDP-1";
            mode = "3840x2160@60.000Hz";
            position = "0,0";
            scale = 2.0;
          }
          {
            criteria = "HDMI-A-1";
            mode = "3440x1440";
            scale = 1.0;
            position = "1920,0";
          }
        ];
      }
    ];
  };
in {
  enable = true;
  settings = configurationProfiles.${configurationName};
}
