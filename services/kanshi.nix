{configurationName}: let
  monitorSpec = {
    criteria = "HDMI-A-1";
    mode = "3440x1440";
    scale = 1.0;
    position = "1920,0";
  };
  configurationProfiles = {
    bellerophon = let
      laptopSpec = {
        criteria = "eDP-1";
        mode = "1920x1080";
        position = "0,0";
      };
    in [
      {
        profile.name = "mobile";
        proifle.outputs = [laptopSpec];
      }
      {
        profile.name = "workstation";
        profile.outputs = [laptopSpec monitorSpec];
      }
    ];
    daedalus = let
      laptopSpec = {
        criteria = "eDP-1";
        mode = "3840x2160@60.000Hz";
        position = "0,0";
        scale = 2.0;
      };
    in [
      {
        profile.name = "mobile";
        profile.outputs = [laptopSpec];
      }
      {
        profile.name = "workstation";
        profile.outputs = [laptopSpec monitorSpec];
      }
    ];
    erymanthian = let
      laptopSpec = {
        criteria = "eDP-1";
        mode = "3840x2400";
        position = "0,0";
        scale = 2.0;
      };
    in [
      {
        profile.name = "mobile";
        profile.outputs = [laptopSpec];
      }
      {
        profile.name = "workstation";
        profile.outputs = [laptopSpec monitorSpec];
      }
    ];
  };
in {
  enable = true;
  settings = configurationProfiles.${configurationName};
}
