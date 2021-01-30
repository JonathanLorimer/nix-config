{ config, ... }:
{
  networking.wireless.networks = {
    "deCrom-5G" = {
      psk = builtins.trace config.sops.secrets.networks.deCrom-5G "Leonardo";
    };
    # "Lorne-5G" = {
    #   psk = config.sops.secrets.networks.Lorne-5G;
    # };
    # "House" = {
    #   psk = config.sops.secrets.networks.House;
    # };
  };
}
