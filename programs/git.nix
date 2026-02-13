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
    key = "223976DB";
    signByDefault = true;
  };
  ignores = [".jj"];
}
