{
  description = "Jonathan Lorimer's NixOS configuration";

  inputs = {
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
    cornelis.url = "github:isovector/cornelis";
  };
  outputs =
    { home-manager
    , nixpkgs
    , nixos-hardware
    , neovim-nightly-overlay
    , sops-nix
    , nix-colors
    , idris2-pkgs
    , cornelis
    , ...
    }:
    let system = "x86_64-linux";
    in {
    nixosConfigurations = {
      bellerophon = nixpkgs.lib.nixosSystem {
        inherit system;
        modules = [
          # Modules
          ./modules/base.nix
          ./modules/hardware-configuration.nix
          ./modules/vpn.nix
          ./modules/postgres.nix
          ./modules/nix.nix
          ((import ./modules/overlays.nix) { inherit neovim-nightly-overlay idris2-pkgs;})
          ./modules/pipewire.nix

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
                cornelis = cornelis.packages."${system}".cornelis;
                cornelis-vim = cornelis.packages."${system}".cornelis-vim;
              };
            }
        ];
      };
    };
  };
}
