{
	boot.loader.grub = {
		enable = true;
		device = "nodev";
		efiSupport = true;
		enableCryptodisk = true;
	};
	boot.initrd.luks.devices = {
		root = {
			device = "/dev/disk/by-uuid/9b532960-071f-49eb-b98e-164ba9d1e5f0";
			preLVM = true;
		};
	};
}

