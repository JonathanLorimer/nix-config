{
  description = "Jonathan Lorimer's NixOS configuration";

  inputs = {
    nixpkgs.url = github:nixos/nixpkgs/nixpkgs-unstable;
    home-manager.url = github:nix-community/home-manager;
    nixos-hardware.url = github:NixOS/nixos-hardware/master;
    neovim-nightly-overlay.url = github:nix-community/neovim-nightly-overlay;
    sops-nix.url = github:Mic92/sops-nix;
    nix-colors.url = github:misterio77/nix-colors;
    cornelis.url = github:isovector/cornelis;
    mercury.url = "git+ssh://git@github.com/mercurytechnologies/nixos-configuration.git?ref=main";
  };
  outputs = {
    home-manager,
    nixpkgs,
    nixos-hardware,
    neovim-nightly-overlay,
    sops-nix,
    nix-colors,
    cornelis,
    mercury,
    ...
  }: let
    system = "x86_64-linux";
    commonModules = configurationName: [
      # Modules
      ./modules/base.nix
      ./modules/postgres.nix
      ./modules/nix.nix
      ((import ./modules/channels.nix) {inherit nixpkgs;})
      ((import ./modules/overlays.nix) {inherit neovim-nightly-overlay;})
      ./modules/pipewire.nix
      ./modules/tailscale.nix
      ./modules/certs

      # Secrets
      sops-nix.nixosModules.sops

      # Home Manager
      home-manager.nixosModules.home-manager
      {
        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;
        home-manager.users.jonathanl = (import ./jonathanl.nix) {
          inherit nixpkgs configurationName;
          colours = nix-colors;
          cornelis = cornelis.packages."${system}".cornelis;
          cornelis-vim = cornelis.packages."${system}".cornelis-vim;
        };
      }
    ];
  in {
    formatter.${system} = nixpkgs.legacyPackages.${system}.alejandra;
    nixosConfigurations = {
      bellerophon = nixpkgs.lib.nixosSystem {
        inherit system;
        modules =
          (commonModules "bellerophon")
          ++ [
            ./modules/bellerophon/hardware-configuration.nix
            ./modules/bellerophon/sops

            # Hardware
            nixos-hardware.nixosModules.lenovo-thinkpad-x1-7th-gen
            nixpkgs.nixosModules.notDetected
          ];
      };
      daedalus = nixpkgs.lib.nixosSystem {
        inherit system;
        modules =
          (commonModules "daedalus")
          ++ [
            ./modules/daedalus/hardware-configuration.nix
            ./modules/daedalus/nix.nix
            # Hardware
            nixos-hardware.nixosModules.lenovo-thinkpad-t14s
            nixpkgs.nixosModules.notDetected
          ];
      };
    };
  };
}
