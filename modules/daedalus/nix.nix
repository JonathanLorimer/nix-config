{pkgs, ...}: {
  nix.settings.max-jobs = pkgs.lib.mkDefault 24;
}
