{
  description = "Jonathan Lorimer's NixOS configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    sops-nix.url = "github:Mic92/sops-nix";
    nix-colors.url = "github:misterio77/nix-colors";
    cornelis.url = "github:isovector/cornelis";
    tau = {
      url = "github:JonathanLorimer/tau";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    kolide = {
      url = "github:kolide/nix-agent/main";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    impala.url = "github:Samuel-Martineau/impala/package-for-nixos";
    nur.url = "github:nix-community/NUR";
    scls.url = "github:estin/simple-completion-language-server";
    sentinelone.url = "github:devusb/sentinelone-nix";
  };
  outputs = {
    home-manager,
    nixpkgs,
    nixos-hardware,
    sops-nix,
    nix-colors,
    cornelis,
    kolide,
    impala,
    nur,
    scls,
    tau,
    sentinelone,
    ...
  }: let
    system = "x86_64-linux";
    font = import ./font {usePragmata = true;};
    commonModules = configurationName: [
      # Personal Modules
      ./modules/base.nix
      ./modules/postgres.nix
      ./modules/nix.nix
      ((import ./modules/channels.nix) {inherit nixpkgs;})
      ((import ./modules/overlays.nix) {inherit nur sentinelone;})
      ./modules/pipewire.nix
      ./modules/tailscale.nix
      ./modules/certs
      ./modules/gaming.nix
      ./modules/unfreePackages.nix
      ./modules/login.nix
      ./modules/miniflux.nix
      ./modules/docker.nix
      font.module

      # External Modules
      nur.nixosModules.nur
      tau.nixosModules.default
      {
        programs.tau = {
          enable = true;
          enforce = true;
        };
      }

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
          inherit (font) default-font;
          tauModule = tau.homeManagerModules.default;
          colours = nix-colors;
          cornelis = cornelis.packages."${system}".cornelis;
          cornelis-vim = cornelis.packages."${system}".cornelis-vim;
          impala = impala.packages."${system}".impala;
          scls = scls.defaultPackage."${system}";
        };
      }
    ];
  in {
    formatter.${system} = nixpkgs.legacyPackages.${system}.alejandra;
    nixosConfigurations = {
      # Installation ISO with ZFS support
      installer = nixpkgs.lib.nixosSystem {
        inherit system;
        modules = [
          ./image.nix
        ];
      };
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
          ];
      };
      erymanthian = nixpkgs.lib.nixosSystem {
        inherit system;
        modules =
          (commonModules "erymanthian")
          ++ [
            ./modules/erymanthian/hardware-configuration.nix
            ./modules/erymanthian/nix.nix
            ./modules/erymanthian/encryption.nix
            ./modules/erymanthian/host.nix
            ./modules/erymanthian/impermanence.nix
            ./modules/erymanthian/users.nix
            ./modules/erymanthian/state-version.nix
            ./modules/erymanthian/gpu.nix
            ./modules/erymanthian/sway.nix
            ./modules/erymanthian/sops.nix

            # Hardware - generic ThinkPad (P16 Gen 2 not in nixos-hardware yet)
            nixos-hardware.nixosModules.lenovo-thinkpad
            nixpkgs.nixosModules.notDetected

            # Mercury
            sentinelone.nixosModules.sentinelone
            ({
              pkgs,
              config,
              ...
            }: {
              services.sentinelone = {
                enable = true;
                sentinelOneManagementTokenPath = config.sops.secrets.s1_mgmt_token.path; # Point to the file with the enrollment key
                customerId = "jonathan@mercury.com-erymanthian"; # USE: emailAddress-hostname
                package = pkgs.sentinelone.overrideAttrs (old: {
                  pname = "sentinelagent";
                  version = "25.4.1.24"; # Match the package version
                  src = ./SentinelAgent_linux_x86_64_v25_4_1_24.deb; # Point to the package you've downloaded
                });
              };
            })
            kolide.nixosModules.kolide-launcher
            {
              nixpkgs.allowUnfreePackages = ["kolide-launcher"];
              services.kolide-launcher.enable = true;
              environment.etc."kolide-k2/secret" = {
                mode = "0600";
                text = "eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCJ9.eyJvcmdhbml6YXRpb24iOiJuYWtvbmUiLCJraWQiOiJiODoxZDowNjo5NzpjYjo3OTpjMDo3MTpjNDoxNTpjZDo5Yzo4Mjo0MDo4NjpjYSIsImNyZWF0ZWRBdCI6IjE3MDUxMTgwMzYiLCJjcmVhdGVkQnkiOiJrd29ya2VyIn0.vCMoj_pnDjEG3Ji9y8elRzN10QfFOwGxZrJAQcJWP41SmDN1PsLQusKucX7lwUTlfgm6-9mKLnaJ9uhA-2j0G2_J2TCP9KxyvZ2M2jH4x_5muf1kV99RgwJhhjlFbZU_9ri8ZZc-fOlaaFZi6hKg5GwaaLSNTex2HKzfcx3PVdDjaXoAKc-THHgtQ9-j_4P_co7JkxxCgnsqpMw13qm2nNZ5PAE2wOuU1_MdVeNam4MnLt1BBgxbeclCHfKjrcg-H9UDcQtwiYxllsfDSpmgfNDr2b69Y064UqKAjqWyvE33c-7hBx_R2HC9glXulmdijgPgGABT1Ad6zhA6QS8xTg";
              };
              environment.etc."kolide-k2/launcher.flags" = {
                text = ''
                  autoupdate
                  transport jsonrpc
                  hostname k2device.kolide.com
                  root_directory /var/kolide-k2/k2device.kolide.com
                  enroll_secret_path /etc/kolide-k2/secret
                  update_channel stable
                '';
                mode = "0600";
                user = "root";
                group = "root";
              };
            }
          ];
      };
    };
  };
}
