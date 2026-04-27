{pkgs, ...}: {
  boot.supportedFilesystems = ["zfs"];
  boot.zfs.forceImportRoot = false;
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
    "/var/kolide-k2" = {
      device = "/persist/var/kolide-k2";
      fsType = "none";
      options = ["bind"];
    };
    "/persist".neededForBoot = true;
  };

  # Ensure all user processes are killed when the session ends during shutdown,
  # preventing lingering processes from holding /home open and blocking ZFS unmount.
  services.logind.settings.Login.KillUserProcesses = true;

  # Swap is configured as a ZFS zvol (rpool/swap).
  # Future installs use a dedicated swap partition instead (see install/partition.sh).
  # Remove the zvol swap config after reinstalling.
  swapDevices = [
    {device = "/dev/zvol/rpool/swap";}
  ];

  systemd.services.tailscaled.serviceConfig.BindPaths = "/persist/var/lib/tailscale:/var/lib/tailscale";
}
