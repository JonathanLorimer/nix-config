{
  pkgs,
  colorscheme,
  term-env,
  default-font,
  cornelis-vim,
  helix,
  scls,
}: let
  fzf-module = (import ./fzf) {inherit pkgs colorscheme;};
in {
  alacritty = (import ./alacritty) {inherit pkgs colorscheme term-env default-font;};
  bat.config.theme = "Nord";
  bat.enable = true;
  btop = {
    enable = true;
    settings = {
      "vim_keys" = true;
      "proc_sorting" = "memory";
    };
  };
  direnv = {
    enable = true;
    enableZshIntegration = true;
    nix-direnv.enable = true;
  };
  delta = {
    enable = true;
    enableGitIntegration = true;
    options = {
      line-numbers = true;
      side-by-side = true;
      syntax-theme = "Nord";
    };
  };
  emacs = (import ./emacs.nix) {inherit pkgs;};
  eza = {
    enable = true;
    enableZshIntegration = true;
    git = true;
  };
  firefox = (import ./firefox.nix) {inherit pkgs;};
  ghostty = (import ./ghostty.nix) {inherit colorscheme default-font pkgs;};
  git = import ./git.nix;
  gpg.enable = true;
  helix = (import ./helix) {inherit colorscheme pkgs helix scls;};
  htop.enable = true;
  jujutsu = (import ./jujutsu) {inherit (pkgs) delta meld;};
  # neovim = (import ./nvim) {inherit pkgs cornelis-vim;};
  obs-studio = (import ./obs-studio.nix) {inherit pkgs;};
  ripgrep.enable = true;
  fzf = fzf-module.config;
  ssh = {
    enable = true;
    matchBlocks."*".addKeysToAgent = "yes";
    enableDefaultConfig = false;
    extraConfig = ''
      Host *
        User jonathanl
        IdentityFile ~/.ssh/id_rsa
        AddKeysToAgent yes
      Host *
        User jonathanl
        IdentityFile ~/.ssh/id_ed25519
        AddKeysToAgent yes
    '';
  };
  starship = import ./starship.nix;
  swaylock = import ./swaylock.nix {inherit colorscheme pkgs;};
  tmux = (import ./tmux) {inherit (pkgs) tmuxPlugins;};
  vscode.enable = true;
  waybar = import ./waybar;
  yazi.enable = true;
  zathura.enable = true;
  zellij = (import ./zellij) {inherit colorscheme;};
  zoxide.enable = true;
  zoxide.enableZshIntegration = true;
  zsh = (import ./zsh) {inherit pkgs;};
}
