{
  boot.loader.grub = {
    enable = true;
    device = "nodev";
    efiSupport = true;
    enableCryptodisk = true;
  };
  boot.loader.efi.canTouchEfiVariables = true;
  boot.initrd.luks.devices = {
    root = {
      device = "/dev/disk/by-uuid/8a9701b4-8665-4ca7-b8f8-2bc5ec8dc754";
      preLVM = true;
    };
  };
}
