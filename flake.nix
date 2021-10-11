{
  description = "Jonathan Lorimer's NixOS configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";
    sops-nix.url = "github:Mic92/sops-nix";
  };

  outputs =
    { home-manager
    , nixpkgs
    , nixos-hardware
    , neovim-nightly-overlay
    , sops-nix
    , ...
    }: {
    nixosConfigurations = {
      bellerophon = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          # Modules
          ./configuration.nix
          ./hardware-configuration.nix
          ./vpn.nix
          ./monitoring.nix
          ./postgres.nix
          ./nix.nix
          ((import ./overlays.nix) neovim-nightly-overlay)

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
              home-manager.users.jonathanl = import ./home.nix;
            }
        ];
      };
    };
  };
}
