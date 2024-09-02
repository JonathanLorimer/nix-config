{pkgs, ...}: {
  services.miniflux = {
    enable = true;
    createDatabaseLocally = true;
    adminCredentialsFile = pkgs.writeTextFile {
      name = "miniflux.conf";
      text = ''
        ADMIN_USERNAME=jonathanlorimer
        ADMIN_PASSWORD=somethingsimple
      '';
    };
    config = {
      LISTEN_ADDR = "127.0.0.1:8031";
    };
  };
}
