 { colours }: { config, pkgs, ... }:
let
  nord = with builtins; mapAttrs (_: value: "#${value}") colours.colorSchemes.nord.colors;
in {
  imports = [ colours.homeManagerModule ];
  home = (import ./home.nix) { inherit pkgs; };
  programs = (import ./programs/default.nix) { inherit pkgs nord; };
  services = (import ./services);
  wayland.windowManager.sway = (import ./sway) { inherit pkgs nord; };
}
