{pkgs, nord, term-env, default-font, cornelis-vim}:
{
  alacritty = (import ./alacritty) {inherit pkgs nord term-env default-font; };
  bat.enable = true;
  bat.config.theme = "Nord";
  direnv = {
    enable = true;
    enableZshIntegration = true;
    nix-direnv.enable = true;
  };
  # doom-emacs = {
  #   enable = true;
  #   doomPrivateDir = ./doom.d;
  #   emacsPackage = pkgs.emacsPgtkGcc;
  # };
  git = import ./git.nix;
  gpg.enable = true;
  htop.enable = true;
  mako = (import ./mako.nix) {inherit nord default-font; };
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
  zsh = (import ./zsh.nix) {inherit pkgs;};
}

