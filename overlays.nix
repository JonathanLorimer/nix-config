# This might be a bit confusing to some. A nixos module can be a static attrset
# or a function of the shape { pkgs, other-deps-here, ...}: {...}
# https://nixos.wiki/wiki/Module#Function.  I want a nixos module function
# which is called by nixos internals, but I also want to provide the
# neovim-nightly-overlay, which is an input from my flake. Therefore I need to
# create a curried function, so I can use partial application to provide
# neovim-nightly overlay from flake.nix and still get a nixos module function.
neovim-nightly-overlay: { pkgs, ... }: {
  nixpkgs.overlays = [
    neovim-nightly-overlay.overlay

    # home manager uses neovim-unwrapped
    (final: prev: {
      neovim-unwrapped = final.neovim-nightly;
    })

    # get access to my :sick: font
    (final: prev: {
      pragmata-pro = final.callPackage ./pragmata-pro {};
    })
  ];
}
