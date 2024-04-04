{ pkgs }:
{
  enable = true;
  package = pkgs.obs-studio;
  plugins = [
    pkgs.obs-studio-plugins.wlrobs
  ];
}
