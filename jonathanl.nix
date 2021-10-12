{ config, pkgs, ... }:
let
  nord = import ./nord.nix;
in {
    home = (import ./home.nix) { inherit pkgs; };
    programs = (import ./programs/default.nix) { inherit pkgs nord; };
    services = (import ./services);
    wayland.windowManager.sway = (import ./sway) { inherit pkgs nord; };
}
