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
  sopsPGPKeys = [./jonathanl.asc ];
  nativeBuildInputs = [
    sops-nix.sops-pgp-hook

    # This is for editing the sops, but allows an individual to generate
    # a gpg key from an ssh key in the shell.
    sops-nix.ssh-to-pgp
  ];
}
