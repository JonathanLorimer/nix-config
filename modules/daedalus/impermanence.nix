{
  lib,
  config,
  ...
}: {
  boot.supportedFilesystems = ["zfs"];
  boot.kernelPackages = config.boot.zfs.package.latestCompatibleLinuxPackages;
  boot.initrd.postDeviceCommands = lib.mkAfter ''
    zfs rollback -r rpool/local/root@blank
  '';

  # State files
  environment.etc."NetworkManager/system-connections" = {
    source = "/persist/etc/NetworkManager/system-connections/";
  };
}
