{pkgs, ...}: {
  xdg.portal.enable = true;
  xdg.portal.extraPortals = [pkgs.xdg-desktop-portal-wlr];
  services.pipewire.enable = true;
  services.pipewire.audio.enable = true;
  services.pipewire.wireplumber.enable = true;
  services.pipewire.alsa.enable = true;
  services.pipewire.jack.enable = true;
  services.pipewire.pulse.enable = true;
}
