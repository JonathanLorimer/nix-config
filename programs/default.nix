{
  pkgs,
  colorscheme,
  term-env,
  default-font,
  cornelis-vim,
  helix,
  ghostty,
  scls,
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
  eza = {
    enable = true;
    enableZshIntegration = true;
    git = true;
  };
  firefox = (import ./firefox.nix) {inherit pkgs;};
  ghostty = {
    enable = true;
    package = ghostty;
  };
  git = import ./git.nix;
  gpg.enable = true;
  # TODO: figure out a way to add this to gpg conf
  # extraConfig = ''
  #   keyserver hkps://keys.openpgp.org
  # '';
  helix = (import ./helix) {inherit colorscheme pkgs helix scls;};
  htop.enable = true;
  jujutsu = (import ./jujutsu) {inherit (pkgs) delta meld;};
  # neovim = (import ./nvim) {inherit pkgs cornelis-vim;};
  obs-studio = (import ./obs-studio.nix) {inherit pkgs;};
  ripgrep.enable = true;
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
