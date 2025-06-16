{
  colorscheme,
  default-font,
  configurationName,
  pkgs,
}: {
  spotifyd.enable = true;
  gpg-agent = {
    enable = true;
    enableSshSupport = true;
    enableZshIntegration = true;
    defaultCacheTtl = 1 * 60 * 60;
    maxCacheTtl = 1 * 60 * 60 * 24;
    pinentry.package = pkgs.pinentry-tty;
    verbose = true;
  };
  swayidle = {
    enable = true;
    timeouts = [
      {
        timeout = 900;
        command = "${pkgs.swaylock}/bin/swaylock -f";
      }
      {
        timeout = 1500;
        command = "${pkgs.sway}/bin/swaymsg 'output * dpms off'";
        resumeCommand = "${pkgs.sway}/bin/swaymsg 'output * dpms on'";
      }
    ];
  };
  mako = (import ./mako.nix) {inherit colorscheme default-font;};
  kanshi = (import ./kanshi.nix) {inherit configurationName;};
}
