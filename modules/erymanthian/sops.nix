{
  sops = {
    defaultSopsFormat = "json";

    age = {
      # Read directly from the persistent dataset. /persist is a real filesystem
      # mount available in early boot — NOT an impermanence bind-mount — so the
      # key is present before sops decrypts at activation/boot.
      keyFile = "/persist/sops/age/keys.txt";
      generateKey = false; # we created it by hand
      sshKeyPaths = []; # native age only — this is what drops ssh-to-age
    };

    secrets.s1_mgmt_token = {
      sopsFile = ../../secrets/sops.json;
    };
  };
}
