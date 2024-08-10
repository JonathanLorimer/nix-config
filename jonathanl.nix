{
  colours,
  cornelis,
  cornelis-vim,
  nixpkgs,
  configurationName,
  impala,
}: {
  pkgs,
  config,
  ...
}: let
  colorscheme = (import ./colors.nix).zenwritten-desat;
  env-vars = {
    EDITOR = "hx";
    TERMINAL = "alacritty";
    BROWSER = "firefox";
    NIX_PATH = "nixpkgs=${config.xdg.configHome}/nix/inputs/nixpkgs";
  };
  default-font = "PragmataProMonoLiga Nerd Font";
in {
  imports = [
    colours.homeManagerModule
  ];
  nix.registry.nixpkgs.flake = nixpkgs;
  xdg.configFile = {
    "nix/inputs/nixpkgs".source = nixpkgs.outPath;
    "nvim/lua".source = ./programs/nvim/lua;
  };
  home = (import ./home.nix) {
    inherit pkgs env-vars cornelis impala;
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
