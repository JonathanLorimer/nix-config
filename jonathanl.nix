 { colours, doom-emacs }: { config, pkgs, ... }:
let
  nord = with builtins; mapAttrs (_: value: "#${value}") colours.colorSchemes.nord.colors;
  scripts = (import ./scripts) {inherit pkgs;};
  env-vars = {
    EDITOR = "nvim";
    TERMINAL = "alacritty";
    CODE_DIR = "Code";
    WORK_DIR = "Mercury";
  };
  default-font = "PragmataProLiga Nerd Font";
in {
  imports = [ colours.homeManagerModule doom-emacs.hmModule ];
  home = (import ./home.nix) { inherit pkgs scripts env-vars; };
  programs = (import ./programs/default.nix) { inherit pkgs nord default-font; term-env = env-vars; };
  services = (import ./services);
  wayland.windowManager.sway = (import ./sway) { inherit pkgs nord default-font; };
}
