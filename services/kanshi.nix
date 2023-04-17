{ configurationName }:
let
  configurationProfiles = {
    bellerophon = {
        mobile.outputs = [
          {
            criteria = "eDP-1";
            mode = "1920x1080";
            position = "0,0";
          }
        ];
        workstation.outputs = [
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
    daedalus = {
        mobile.outputs = [
          {
            criteria = "eDP-1";
            mode = "3840x2160@60.000Hz";
            position = "0,0";
            scale = 2.0;
          }
        ];
        workstation.outputs = [
          {
            criteria = "eDP-1";
            mode = "3840x2160@60.000Hz";
            position = "0,0";
            scale = 2.0;
          }
          {
            criteria = "HDMI-A-1";
            mode = "3440x1440";
            position = "1920,0";
          }
        ];
    };
  };
in
{
  enable = true;
  profiles = configurationProfiles.${configurationName};
}
