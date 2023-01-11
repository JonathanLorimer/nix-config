{pkgs}:
let zsh-nix-shell = {
        name = "zsh-nix-shell";
        file = "nix-shell.plugin.zsh";
        src = pkgs.fetchFromGitHub {
          owner = "chisui";
          repo = "zsh-nix-shell";
          rev = "v0.4.0";
          sha256 = "037wz9fqmx0ngcwl9az55fgkipb745rymznxnssr3rx9irb6apzg";
        };
      };
in
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
    ne = "nvim $(git status --porcelain | awk '{print $2}' | sk)";
    gs = "git status";
    gc = "git commit";
    ga = "git add";
    gp = "git push";
    gr = "git remote add";
    cd = "z";
    wl = "nmcli d wifi list";
    wc = "nmcli d wifi connect";
    wd = "nmcli con down id";
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

