{
  colours,
  cornelis,
  cornelis-vim,
  nixpkgs,
  configurationName,
}: {
  pkgs,
  config,
  ...
}: let
  colorscheme = (import ./colors.nix).zenwritten-desat;
  scripts = (import ./scripts) {inherit pkgs;};
  env-vars = {
    EDITOR = "nvim";
    TERMINAL = "alacritty";
    BROWSER = "firefox";
    CODE_DIR = "Code";
    WORK_DIR = "Holdings";
    NIX_PATH = "nixpkgs=${config.xdg.configHome}/nix/inputs/nixpkgs";
  };
  default-font = "PragmataProMonoLiga Nerd Font";
in {
  imports = [colours.homeManagerModule];
  nix.registry.nixpkgs.flake = nixpkgs;
  xdg.configFile = {
    "nix/inputs/nixpkgs".source = nixpkgs.outPath;
    "nvim/lua".source = ./programs/nvim/lua;
  };
  home = (import ./base.nix) {
    inherit pkgs scripts env-vars;
    cornelis = cornelis;
  };
  programs = (import ./programs/default.nix) {
    inherit pkgs colorscheme default-font;
    cornelis-vim = cornelis-vim;
    term-env = env-vars;
  };
  services = (import ./services) {
    inherit colorscheme default-font configurationName pkgs;
  };
  wayland.windowManager.sway = (import ./sway) {inherit pkgs colorscheme default-font;};
}
