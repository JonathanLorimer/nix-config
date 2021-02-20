{config, ...}:
{
  sops.secrets = {
    mercury-vpn-ca.owner = config.users.users.jonathanl.name;
    mercury-vpn-cert.owner = config.users.users.jonathanl.name;
    mercury-vpn-key.owner = config.users.users.jonathanl.name;
  };
  services.openvpn.servers = {
    mercury = {
      autoStart = false;
      updateResolvConf = true;
      config = ''
        remote vpn.mercury.com 1194 udp
        nobind
        dev tun
        persist-tun
        persist-key
        compress
        pull
        auth-user-pass
        tls-client
        ca ${config.sops.secrets.mercury-vpn-ca.path}
        cert ${config.sops.secrets.mercury-vpn-cert.path}
        key ${config.sops.secrets.mercury-vpn-key.path}
        remote-cert-tls server
        auth-nocache
        reneg-sec 0
      '';
    };
  };
}
