{nixpkgs, ...}: {
  "nix/inputs/nixpkgs".source = nixpkgs.outPath;
  "helix/unicode-input/base.toml".source = ../programs/helix/unicode.toml;
  "zellij/config.kdl".source = ../programs/zellij/config.kdl;
}
