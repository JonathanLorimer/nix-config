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
    key = "ED39 CDCE CFEE 3EC7 EAC8  F679 E2D2 A5D3 05AB F31E";
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

