{lib, ...}: {
  boot.supportedFilesystems = ["zfs"];
  boot.initrd.postDeviceCommands = lib.mkAfter ''
    zfs rollback -r rpool/local/root@blank
  '';

  # State files
  environment.etc."NetworkManager/system-connections" = {
    source = "/persist/etc/NetworkManager/system-connections/";
  };

  systemd.tmpfiles.rules = [
    "L /var/lib/postgresql - - - - /persist/var/lib/postgresql"
    "L /var/lib/iwd - - - - /persist/var/lib/iwd"
    "L /var/kolide-k2 - - - - /persist/var/kolide-k2"
  ];

  systemd.services.tailscaled.serviceConfig.BindPaths = "/persist/var/lib/tailscale:/var/lib/tailscale";
}
