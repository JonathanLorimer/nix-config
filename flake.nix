{
  description = "Jonathan Lorimer's NixOS configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    hardware-config = {
      url = "/home/jonathanl/.config/nixpkgs/hardware-configuration.nix";
      flake = false;
    };
    vpn = {
      url = "/home/jonathanl/.config/nixpkgs/vpn/default.nix";
      flake = false;
    };
    secrets = {
      url = "/home/jonathanl/.config/nixpkgs/secrets.nix";
      flake = false;
    };
    neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";
  };

  outputs =
    { home-manager
    , nixpkgs
    , nixos-hardware
    , neovim-nightly-overlay
    , hardware-config
    , vpn
    , secrets
    , ...
    }: {
    nixosConfigurations = {
      bellerophon = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./configuration.nix

          # Mercury VPN
          vpn

          # Hardware
          hardware-config
          nixos-hardware.nixosModules.lenovo-thinkpad-x1-7th-gen

          # Overlay
          ({ pkgs, ... }: {
            nixpkgs.overlays = [neovim-nightly-overlay.overlay];
          })

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
