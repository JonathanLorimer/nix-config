{
  pkgs,
  nixpkgs,
}: {
  configFile = (import ./configFiles.nix) {inherit nixpkgs;};
  portal = (import ./portals.nix) {inherit pkgs;};
  mimeApps = {
    enable = true;
    defaultApplications = {
      "x-scheme-handler/http" = "firefox.desktop";
      "x-scheme-handler/https" = "firefox.desktop";
    };
  };
}
