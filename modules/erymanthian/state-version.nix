{
  # Fresh install - use current NixOS version
  # Verify with: nix-instantiate --eval -E '(import <nixpkgs> {}).lib.version'
  system.stateVersion = "25.11";
}
