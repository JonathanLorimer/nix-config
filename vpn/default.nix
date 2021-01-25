{...}: {
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
				ca ${./ca.crt}
				cert ${./jonathanlorimer.crt}
				key ${./jonathanlorimer.key}
				remote-cert-tls server
				auth-nocache
				reneg-sec 0
			'';
		};
	};
}
