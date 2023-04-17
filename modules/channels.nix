{nixpkgs}: {pkgs, ...}: {
  environment.etc."nix/inputs/nixpkgs".source = nixpkgs.outPath;
  nix.nixPath = ["nixpkgs=/etc/nix/inputs/nixpkgs"];
  nix.registry.nixpkgs.flake = nixpkgs;
}
