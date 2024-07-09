{
  nixpkgs.overlays = [
    # get access to my font
    (final: prev: {
      pragmata-pro-console = (final.callPackage ../pragmata-pro {}).console;
      pragmata-pro = (final.callPackage ../pragmata-pro {}).unpatched;
      pragmata-pro-patched = (final.callPackage ../pragmata-pro {}).patched;
    })
  ];
}
