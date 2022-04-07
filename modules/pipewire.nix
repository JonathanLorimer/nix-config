{ pkgs, ...}:
{
  xdg.portal.enable = true;
  xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-wlr ];
  services.pipewire.enable = true;
}
