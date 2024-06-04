{
  nixpkgs.overlays = [
    # get access to my font
    (final: prev: {
      pragmata-pro = (final.callPackage ../pragmata-pro {}).unpatched;
      pragmata-pro-patched = (final.callPackage ../pragmata-pro {}).patched;
    })
  ];
}
