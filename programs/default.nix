{pkgs, colorscheme, term-env, default-font, cornelis-vim}:
{
  alacritty = (import ./alacritty) {inherit pkgs colorscheme term-env default-font; };
  bat.config.theme = "Nord";
  bat.enable = true;
  direnv = {
    enable = true;
    enableZshIntegration = true;
    nix-direnv.enable = true;
  };
  fzf.enable = true;
  fzf.enableZshIntegration = true;
  git = import ./git.nix;
  gpg.enable = true;
  htop.enable = true;
  mako = (import ./mako.nix) {inherit colorscheme default-font; };
  neovim = (import ./nvim) { inherit pkgs cornelis-vim; };
  skim = import ./skim.nix;
  ssh = {
    enable = true;
    extraConfig = ''
      Host *
        User jonathanl
        IdentityFile ~/.ssh/id_rsa
        AddKeysToAgent yes
    '';
  };
  starship = import ./starship.nix;
  swaylock = import ./swaylock.nix { inherit colorscheme; };
  taskwarrior.enable = true;
  tmux = (import ./tmux) { inherit (pkgs) tmuxPlugins; };
  waybar = import ./waybar;
  zathura.enable = true;
  zellij = (import ./zellij) {inherit colorscheme; };
  zoxide.enable = true;
  zoxide.enableZshIntegration = true;
  zsh = (import ./zsh.nix) {inherit pkgs;};
}

