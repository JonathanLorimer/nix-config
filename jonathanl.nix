 { colours }: { config, pkgs, ... }:
let
  nord = with builtins; mapAttrs (_: value: "#${value}") colours.colorSchemes.nord.colors;
  scripts = (import ./scripts) {inherit pkgs;};
  env-vars = {
    EDITOR = "nvim";
    TERMINAL = "alacritty";
    CODE_DIR = "Code";
    WORK_DIR = "Mercury";
  };
in {
  imports = [ colours.homeManagerModule ];
  home = (import ./home.nix) { inherit pkgs scripts env-vars; };
  programs = (import ./programs/default.nix) { inherit pkgs nord; term-env = env-vars; };
  services = (import ./services);
  wayland.windowManager.sway = (import ./sway) { inherit pkgs nord; };
}
