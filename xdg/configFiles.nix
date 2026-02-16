{nixpkgs, ...}: {
  "nix/inputs/nixpkgs".source = nixpkgs.outPath;
  "helix/unicode-input/base.toml".source = ../programs/helix/unicode.toml;
  "zellij/config.kdl".source = ../programs/zellij/config.kdl;
  "zellij/layouts/work.kdl".source = ../programs/zellij/layouts/work.kdl;
}
