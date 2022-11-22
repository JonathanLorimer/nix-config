{config, ...}:
{
  sops.secrets = {
    pg-admin-password.owner = config.users.users.jonathanl.name;
  };
}
