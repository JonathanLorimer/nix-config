{pkgs}: let
  zsh-nix-shell = {
    name = "zsh-nix-shell";
    file = "nix-shell.plugin.zsh";
    src = pkgs.fetchFromGitHub {
      owner = "chisui";
      repo = "zsh-nix-shell";
      rev = "v0.8.0";
      sha256 = "1lzrn0n4fxfcgg65v0qhnj7wnybybqzs4adz7xsrkgmcsr0ii8b7";
    };
  };
in {
  enable = true;
  dotDir = ".config/zsh";
  autosuggestion.enable = true;
  enableCompletion = true;
  shellAliases = {
    ll = "eza -l";
    l = "eza -lah";
    ls = "eza";
    lt = "eza --long --tree";
    cfg = "nvim $HOME/.config/nixpkgs/home.nix";
    n = "nvim";
    ns = "nvim $(sk)";
    ne = "nvim $(git status --porcelain | awk '{print $2}' | sk)";
    gs = "git status";
    gc = "git commit";
    ga = "git add";
    gp = "git push";
    gr = "git remote add";
    cd = "z";
    w = "iwctl";
  };
  history.expireDuplicatesFirst = true;
  history.ignoreDups = true;
  plugins = [
    zsh-nix-shell
  ];
  oh-my-zsh = {
    enable = true;
    plugins = ["git" "sudo" "ssh-agent"];
  };
}
