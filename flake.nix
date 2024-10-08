{
  description = "Jonathan Lorimer's NixOS configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    home-manager.url = "github:nix-community/home-manager";
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    sops-nix.url = "github:Mic92/sops-nix";
    nix-colors.url = "github:misterio77/nix-colors";
    cornelis.url = "github:isovector/cornelis";
    kolide = {
      url = "github:kolide/nix-agent/main";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    lix-module = {
      url = "https://git.lix.systems/lix-project/nixos-module/archive/2.91.0.tar.gz";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    impala.url = "github:Samuel-Martineau/impala/package-for-nixos";
    nur.url = "github:nix-community/NUR";

    # https://github.com/helix-editor/helix/pull/11164
    helix.url = "github:helix-editor/helix/c0666d1219a82cd4e850a30ca1a7f18294c58e9a";
  };
  outputs = {
    home-manager,
    nixpkgs,
    nixos-hardware,
    sops-nix,
    nix-colors,
    cornelis,
    kolide,
    lix-module,
    impala,
    nur,
    helix,
    ...
  }: let
    system = "x86_64-linux";
    commonModules = configurationName: [
      # Personal Modules
      ./modules/base.nix
      ./modules/postgres.nix
      ./modules/nix.nix
      ((import ./modules/channels.nix) {inherit nixpkgs;})
      ((import ./modules/overlays.nix) {inherit nur;})
      ./modules/pipewire.nix
      ./modules/tailscale.nix
      ./modules/certs
      ./modules/gaming.nix
      ./modules/unfreePackages.nix
      ./modules/login.nix
      ./modules/miniflux.nix

      # External Modules
      lix-module.nixosModules.default
      nur.nixosModules.nur

      # Secrets
      sops-nix.nixosModules.sops

      # Home Manager
      home-manager.nixosModules.home-manager
      {
        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;
        home-manager.backupFileExtension = "backup";
        home-manager.users.jonathanl = (import ./jonathanl.nix) {
          inherit nixpkgs configurationName;
          colours = nix-colors;
          cornelis = cornelis.packages."${system}".cornelis;
          cornelis-vim = cornelis.packages."${system}".cornelis-vim;
          impala = impala.packages."${system}".impala;
          helix = helix.packages."${system}".helix;
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
            ./modules/daedalus/encryption.nix
            ./modules/daedalus/host.nix
            ./modules/daedalus/impermanence.nix
            ./modules/daedalus/users.nix
            ./modules/daedalus/state-version.nix

            # Hardware
            nixos-hardware.nixosModules.lenovo-thinkpad-t14s
            nixpkgs.nixosModules.notDetected

            # Kolide for Mercury
            kolide.nixosModules.kolide-launcher
            {
              nixpkgs.allowUnfreePackages = ["kolide-launcher"];
              services.kolide-launcher.enable = true;
              environment.etc."kolide-k2/secret" = {
                mode = "0600";
                text = "eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCJ9.eyJvcmdhbml6YXRpb24iOiJuYWtvbmUiLCJraWQiOiJiODoxZDowNjo5NzpjYjo3OTpjMDo3MTpjNDoxNTpjZDo5Yzo4Mjo0MDo4NjpjYSIsImNyZWF0ZWRBdCI6IjE3MDUxMTgwMzYiLCJjcmVhdGVkQnkiOiJrd29ya2VyIn0.vCMoj_pnDjEG3Ji9y8elRzN10QfFOwGxZrJAQcJWP41SmDN1PsLQusKucX7lwUTlfgm6-9mKLnaJ9uhA-2j0G2_J2TCP9KxyvZ2M2jH4x_5muf1kV99RgwJhhjlFbZU_9ri8ZZc-fOlaaFZi6hKg5GwaaLSNTex2HKzfcx3PVdDjaXoAKc-THHgtQ9-j_4P_co7JkxxCgnsqpMw13qm2nNZ5PAE2wOuU1_MdVeNam4MnLt1BBgxbeclCHfKjrcg-H9UDcQtwiYxllsfDSpmgfNDr2b69Y064UqKAjqWyvE33c-7hBx_R2HC9glXulmdijgPgGABT1Ad6zhA6QS8xTg";
              };
            }
          ];
      };
    };
  };
}
