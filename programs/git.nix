{
  enable = true;
  userName = "Jonathan Lorimer";
  userEmail = "jonathan_lorimer@mac.com";
  extraConfig = {
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
    "mergetool \"vimdiff\"" = {
      cmd = "nvim -d $BASE $LOCAL $REMOTE $MERGED -c '$wincmd w' -c 'wincmd J'";
      keepBackup = false;
    };
  };
  signing = {
    key = null;
    signByDefault = true;
  };
  delta = {
    enable = true;
    options = {
      line-numbers = true;
      side-by-side = true;
      syntax-theme = "Nord";
    };
  };
  ignores = [".jj"];
}
