{lib, ...}: {
  boot.supportedFilesystems = ["zfs"];
  boot.initrd.postDeviceCommands = lib.mkAfter ''
    zfs rollback -r rpool/local/root@blank
  '';

  # State files
  environment.etc."NetworkManager/system-connections" = {
    source = "/persist/etc/NetworkManager/system-connections/";
  };

  fileSystems = {
    "/var/lib/postgresql" = {
      device = "/persist/var/lib/postgresql";
      fsType = "none";
      options = ["bind"];
    };
    "/var/lib/iwd" = {
      device = "/persist/var/lib/iwd";
      fsType = "none";
      options = ["bind"];
    };
    "/var/lib/kolide-k2" = {
      device = "/persist/var/lib/kolide-k2";
      fsType = "none";
      options = ["bind"];
    };
  };

  systemd.services.tailscaled.serviceConfig.BindPaths = "/persist/var/lib/tailscale:/var/lib/tailscale";
}
