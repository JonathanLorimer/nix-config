{nur}: {
  config,
  lib,
  ...
}: {
  nixpkgs.overlays = [
    nur.overlay
  ];
}
