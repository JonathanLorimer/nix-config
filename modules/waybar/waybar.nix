{ config, pkgs, lib, ... }:
with lib;
let cfg = config.services.waybar;
    settings = pkgs.writeText "waybar.conf" cfg.settings;
    style = pkgs.writeText "waybar.css" cfg.style;
in
{ options = {
    services.waybar = {
      enable = mkEnableOption "Waybar status bar";
      package = mkOption {
        type = types.package;
        default = pkgs.waybar;
        defaultText = literalExample "pkgs.waybar";
        description = "Waybar package to install.";
      };
      settings = mkOption {
        type = types.lines;
        description = "The waybar config file";
        example = ''
        '';
      };
      style = mkOption {
        type = types.lines;
        description = "The waybar CSS style file";
        example = ''
        '';
      };
    };
  };
  config = mkIf cfg.enable {
    systemd.user.services.waybar = {
      Unit = {
        Description = "waybar status bar";
        BindsTo = [ "graphical-session.target" ];
        After = [ "graphical-session-pre.target" ];
      };
      Service = {
        ExecStart = "${cfg.package}/bin/waybar --config ${settings} --style ${style}";
      };
      Install = {
       WantedBy = [ "graphical-session.target" ];
      };
    };
  };
}
