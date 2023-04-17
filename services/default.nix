{
  colorscheme,
  default-font,
  configurationName,
}: let
  configScreenSpec = {
    bellerophon = let
      xOffset = "1920";
    in {
      inherit xOffset;
      output = {
        criteria = "eDP-1";
        mode = "${xOffset}x1080";
        position = "0,0";
      };
    };
    daedalus = let
      xOffset = "3840";
    in {
      inherit xOffset;
      output = {
        criteria = "eDP-1";
        mode = "${xOffset}x2160@60.000Hz";
        position = "0,0";
        scale = 2.0;
      };
    };
  };
in {
  spotifyd.enable = true;
  gpg-agent = {
    enable = true;
    enableSshSupport = true;
    enableZshIntegration = true;
    defaultCacheTtl = 15 * 60;
    pinentryFlavor = "tty";
    verbose = true;
  };
  swayidle = {
    enable = true;
    timeouts = [
      {
        timeout = 300;
        command = "swaylock -f";
      }
      {
        timeout = 600;
        command = "swaymsg 'output * dpms off'";
        resumeCommand = "swaymsg 'output * dpms on'";
      }
    ];
  };
  mako = (import ./mako.nix) {inherit colorscheme default-font;};
  kanshi = {
    enable = true;
    profiles = {
      mobile.outputs = [
        configScreenSpec.${configurationName}.output
      ];
      workstation.outputs = [
        configScreenSpec.${configurationName}.output
        {
          criteria = "HDMI-A-1";
          mode = "3440x1440";
          position = "${configScreenSpec.${configurationName}.xOffset},0";
        }
      ];
    };
  };
}
