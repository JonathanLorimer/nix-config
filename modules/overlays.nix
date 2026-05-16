{
  nur,
  sentinelone,
}: {
  config,
  lib,
  ...
}: {
  nixpkgs.overlays = [
    nur.overlay
    sentinelone.overlays.default
  ];
}
