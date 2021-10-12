{
  enable = true;
  dotDir = ".config/zsh";
  enableAutosuggestions = true;
  enableCompletion = true;
  shellAliases = {
    ll = "exa -l";
    l = "exa -lah";
    ls = "exa";
    lt = "exa --long --tree";
    cfg = "nvim $HOME/.config/nixpkgs/home.nix";
    n = "nvim";
    ns = "nvim $(sk)";
    gs = "git status";
    gc = "git commit";
    ga = "git add";
    gp = "git push";
    gr = "git remote add";
    wl = "nmcli d wifi list";
    wc = "nmcli d wifi connect";
  };
  history.expireDuplicatesFirst = true;
  history.ignoreDups = true;
  oh-my-zsh = {
    enable = true;
    plugins = ["git" "sudo" "ssh-agent"];
  };
}

