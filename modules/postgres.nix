{
  config,
  pkgs,
  ...
}: {
  services.postgresql = {
    package = pkgs.postgresql_15;
    enable = true;
    enableTCPIP = true;
    authentication = pkgs.lib.mkForce ''
      local all all trust
      host all all 0.0.0.0/0 trust
      host all all ::1/128 trust
      host all all 172.17.0.0/16 trust
      host all all 127.0.0.1/32 trust
    '';
    extensions = [
      config.services.postgresql.package.pkgs.postgis
      config.services.postgresql.package.pkgs.pgvector
    ];
    settings = {
      listen_addresses = pkgs.lib.mkForce "*";
      shared_preload_libraries = "pg_stat_statements";
      timezone = "UTC";
      log_timezone = "UTC";
      shared_buffers = 128;
      max_locks_per_transaction = 1024;
      max_connections = 1000;
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
