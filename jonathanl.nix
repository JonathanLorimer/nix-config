 { colours, cornelis, cornelis-vim, nixpkgs }: { pkgs, config, ... }:
let
  nord = with builtins; mapAttrs (_: value: "#${value}") colours.colorSchemes.nord.colors;
  scripts = (import ./scripts) {inherit pkgs;};
  env-vars = {
    EDITOR = "nvim";
    TERMINAL = "alacritty";
    CODE_DIR = "Code";
    WORK_DIR = "Mercury";
    NIX_PATH = "nixpkgs=${config.xdg.configHome}/nix/inputs/nixpkgs";
  };
  default-font = "PragmataProMonoLiga Nerd Font Mono";
in {
  imports = [ colours.homeManagerModule ];
  nix.registry.nixpkgs.flake = nixpkgs;
  xdg.configFile."nix/inputs/nixpkgs".source = nixpkgs.outPath;
  home = (import ./home.nix) {
    inherit pkgs scripts env-vars;
    cornelis = cornelis;
  };
  programs = (import ./programs/default.nix) {
    inherit pkgs nord default-font;
    cornelis-vim = cornelis-vim;
    term-env = env-vars;
  };
  services = (import ./services);
  wayland.windowManager.sway = (import ./sway) { inherit pkgs nord default-font; };
}
