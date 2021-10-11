{
  enable = true;
  userName = "Jonathan Lorimer";
  userEmail = "jonathan_lorimer@mac.com";
  extraConfig = {
    init.defaultBranch = "main";
    pull.rebase = true;
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
    key = "FC71 14BD A311 3C17 05BA  2B67 708C 5C31 E69E D543";
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
}

