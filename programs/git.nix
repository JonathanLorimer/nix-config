{
  enable = true;
  settings = {
    user = {
      name = "Jonathan Lorimer";
      email = "jonathan_lorimer@mac.com";
    };
    safe.directory = "/persist/nix-config";
    init.defaultBranch = "main";
    pull.rebase = true;
    rerere.enabled = true;
    push.autoSetupRemote = true;
    merge = {
      tool = "vimdiff";
      conflictstyle = "diff3";
      prompt = false;
      keepBackup = false;
    };
    mergetool = {
      keepBackup = false;
    };
  };
  signing = {
    format = "openpgp";
    key = "223976DB";
    signByDefault = true;
  };
  ignores = [
    ".jj"
    "tenants/"
  ];
  includes = [
    {
      condition = "gitdir:~/mercury/";
      contents = {
        user = {
          name = "Jonathan Lorimer";
          email = "jonathan@mercury.com";
          signingKey = "B31E 6621 3F0B FEE5 A10B  141F 1699 F323 1DCD 307C";
        };
        commit.gpgSign = true;
      };
    }
  ];
}
