{pkgs, colorscheme, term-env, default-font, cornelis-vim}:
{
  alacritty = (import ./alacritty) {inherit pkgs colorscheme term-env default-font; };
  bat.enable = true;
  bat.config.theme = "Nord";
  direnv = {
    enable = true;
    enableZshIntegration = true;
    nix-direnv.enable = true;
  };
  git = import ./git.nix;
  gpg.enable = true;
  htop.enable = true;
  mako = (import ./mako.nix) {inherit colorscheme default-font; };
  neovim = (import ./nvim) { inherit pkgs cornelis-vim; };
  ssh = {
    enable = true;
    extraConfig = ''
      Host *
        User jonathanl
        IdentityFile ~/.ssh/id_rsa
        AddKeysToAgent yes
    '';
  };
  skim = import ./skim.nix;
  starship = import ./starship.nix;
  tmux = (import ./tmux) { inherit (pkgs) tmuxPlugins; };
  waybar = import ./waybar;
  swaylock = import ./swaylock.nix { inherit colorscheme; };
  zsh = (import ./zsh.nix) {inherit pkgs;};
  kitty = (import ./kitty.nix) {inherit pkgs default-font term-env; };
  taskwarrior.enable = true;
}

