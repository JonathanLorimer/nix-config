{ lib, config, ... }:
{
  options = with lib; {
    nixpkgs.allowUnfreePackages = mkOption {
      type = with types; listOf str;
      default = [];
      example = [ "steam" "steam-original" ];
    };
  };

  config = {
    nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) config.nixpkgs.allowUnfreePackages;
  };
}
