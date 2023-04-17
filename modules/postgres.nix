{
  config,
  pkgs,
  ...
}: {
  services.postgresql = {
    package = pkgs.postgresql_15;
    enable = true;
    enableTCPIP = false;
    authentication = ''
      local all all trust
      host all all 127.0.0.1/32 trust
      host all all ::1/128 trust
    '';
    extraPlugins = [config.services.postgresql.package.pkgs.postgis];
    settings = {
      timezone = "UTC";
      shared_buffers = 128;
      fsync = false;
      synchronous_commit = false;
      full_page_writes = false;
    };
  };
  # services.pgadmin = {
  #   enable = true;
  #   initialEmail = "jonathan_lorimer@mac.com";
  #   initialPasswordFile = "${config.sops.secrets.pg-admin-password.path}";
  # };
}
