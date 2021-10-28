{pkgs, nord, term-env}:
{
  alacritty = (import ./alacritty) {inherit pkgs nord term-env; };
  bat.enable = true;
  bat.config.theme = "Nord";
  direnv.enable = true;
  direnv.enableZshIntegration = true;
  git = import ./git.nix;
  gpg.enable = true;
  htop.enable = true;
  mako = (import ./mako.nix) {inherit nord; };
  neovim = (import ./nvim) {inherit pkgs; };
  ssh.enable = true;
  ssh.extraConfig = ''
    Host *
      User jonathanl
      IdentityFile ~/.ssh/id_rsa
      AddKeysToAgent yes
  '';
  skim = import ./skim.nix;
  starship = import ./starship.nix;
  tmux = (import ./tmux) { inherit (pkgs) tmuxPlugins; };
  waybar = import ./waybar;
  zsh = import ./zsh.nix;
}

