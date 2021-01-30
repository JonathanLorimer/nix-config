with import <nixpkgs> {};
let
  sops-nix = pkgs.callPackage (pkgs.fetchFromGitHub {
    owner = "Mic92";
    repo = "sops-nix";
    rev = "ab321bf72a33adce3bfe20b648c6c0df15ce7426";
    sha256 = "1x0qnxgjlcg35m81nfr17qqx3fdrlc5s9hrz68498isc8132d3p6";
  }) {};
in
mkShell {
  sopsPGPKeys = [./users/jonathanl.asc ];
  nativeBuildInputs = [ sops-nix.sops-pgp-hook sops-nix.ssh-to-pgp ];
}
