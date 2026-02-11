{pkgs, ...}: {
  # P16 Gen 2 typically has 16 cores / 24 threads - adjust based on your CPU
  nix.settings.max-jobs = pkgs.lib.mkDefault 16;
}
