{
  pkgs,
  colorscheme,
  term-env,
  default-font,
  cornelis-vim,
}: {
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
  fzf.enable = true;
  fzf.enableZshIntegration = true;
  git = import ./git.nix;
  gpg.enable = true;
  # TODO: figure out a way to add this to gpg conf
  # extraConfig = ''
  #   keyserver hkps://keys.openpgp.org
  # '';
  htop.enable = true;
  neovim = (import ./nvim) {inherit pkgs cornelis-vim;};
  obs-studio = (import ./obs-studio.nix) { inherit pkgs; };
  skim = import ./skim.nix;
  ssh = {
    enable = true;
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
  taskwarrior.enable = true;
  tmux = (import ./tmux) {inherit (pkgs) tmuxPlugins;};
  waybar = import ./waybar;
  zathura.enable = true;
  zellij = (import ./zellij) {inherit colorscheme;};
  zoxide.enable = true;
  zoxide.enableZshIntegration = true;
  zsh = (import ./zsh.nix) {inherit pkgs;};
}
