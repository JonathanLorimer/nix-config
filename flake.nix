{
  description = "Jonathan Lorimer's NixOS configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
    inputs.nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";
  };

  outputs = { home-manager, nixpkgs, nixos-hardware, neovim-nightly-overlay, ... }: {
    nixosConfigurations = {
      bellerophon = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./configuration.nix
          nixos-hardware.nixosModules.lenovo-thinkpad-x1-7th-gen
          home-manager.nixosModules.home-manager
          ({ nixpkgs.overlays = [neovim-nightly-overlay]; })
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
