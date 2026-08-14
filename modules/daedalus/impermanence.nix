{pkgs, ...}: {
  boot.supportedFilesystems = ["zfs"];
  boot.zfs.forceImportRoot = false;

  # Rollback Logic
  boot.initrd.systemd.services.rollback = {
    description = "Rollback ZFS root to blank snapshot";
    wantedBy = ["initrd.target"];
    after = ["zfs-import-rpool.service"];
    before = ["sysroot.mount"];
    unitConfig.DefaultDependencies = "no";
    serviceConfig = {
      Type = "oneshot";
      ExecStart = "${pkgs.zfs}/bin/zfs rollback -r rpool/local/root@blank";
    };
  };

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
