{
  colorscheme,
  default-font,
  configurationName,
}:
{
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
  kanshi = (import ./kanshi.nix) {inherit configurationName;};
}
