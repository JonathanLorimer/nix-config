{
  home-manager.users.jonathanl = {lib, ...}: {
    wayland.windowManager.sway.extraConfig = lib.mkAfter ''
      input "2:10:TPPS/2_Elan_TrackPoint" {
        scroll_method none
      }
    '';
  };
}
