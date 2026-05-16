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
          signingKey = "1957 0D3E F6B6 D3F9 C1FE  E34B 5E27 4FC2 7BEE 7A20";
        };
        commit.gpgSign = true;
      };
    }
  ];
}
