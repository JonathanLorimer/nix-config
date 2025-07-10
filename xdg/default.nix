{
  pkgs,
  nixpkgs,
}: {
  configFile = (import ./configFiles.nix) {inherit nixpkgs;};
  portal = (import ./portals.nix) {inherit pkgs;};
}
