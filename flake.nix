{
  description = "Jonathan Lorimer's NixOS configuration";

  inputs = {
    # need to set rev due to breaking change against doom emacs overly at this commit:
    # https://github.com/NixOS/nixpkgs/commit/932ab304f0b8e3241c1311b9b731d3d330291715#diff-56c122d979843ece29fff08e6d83c47ccf8cdbfedb68e4de21dd0cae5337dcf4
    # switch back to this after fix:
    # nixpkgs.url = "github:nixos/nixpkgs/nix-unstable";
    # nixpkgs.url = "github:nixos/nixpkgs?rev=c52fe20e10a89f939b824de01035543085675c5d";
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    neovim-nightly-overlay = {
      url = "github:nix-community/neovim-nightly-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-colors = {
      url = "github:misterio77/nix-colors";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    idris2-pkgs = {
      url = "github:claymager/idris2-pkgs";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    emacs-overlay.url = "github:nix-community/emacs-overlay";
    nix-doom-emacs = {
      url = "github:nix-community/nix-doom-emacs";
      inputs.emacs-overlay.follows = "emacs-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    cornelis.url = "github:isovector/cornelis";
    cornelis.inputs.nixpkgs.follows = "nixpkgs";
  };
  outputs =
    { home-manager
    , nixpkgs
    , nixos-hardware
    , neovim-nightly-overlay
    , sops-nix
    , nix-colors
    , idris2-pkgs
    , nix-doom-emacs
    , emacs-overlay
    , cornelis
    , ...
    }: {
    nixosConfigurations = {
      bellerophon = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          # Modules
          ./modules/base.nix
          ./modules/hardware-configuration.nix
          ./modules/vpn.nix
          ./modules/monitoring.nix
          ./modules/postgres.nix
          ./modules/nix.nix
          ((import ./modules/overlays.nix) { inherit neovim-nightly-overlay idris2-pkgs emacs-overlay;})
          ./modules/xdg.nix

          # Secrets
          sops-nix.nixosModules.sops

          # Hardware
          nixos-hardware.nixosModules.lenovo-thinkpad-x1-7th-gen
          nixpkgs.nixosModules.notDetected

          # Home Manager
          home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.jonathanl = (import ./jonathanl.nix) {
                colours = nix-colors;
                doom-emacs = nix-doom-emacs;
                cornelis = cornelis.packages."x86_64-linux".cornelis;
                cornelis-vim = cornelis.packages."x86_64-linux".cornelis-vim;
              };
            }
        ];
      };
    };
  };
}
