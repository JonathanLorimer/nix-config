{ tmuxPlugins }:
{
  enable = true;
  baseIndex = 1;
  historyLimit = 5000;
  plugins = with tmuxPlugins; [
    cpu
    battery
    nord
  ];
  keyMode = "vi";
  shortcut = "a";
  terminal = "alacritty";
  extraConfig = ''
    # speed up nvim normal mode
    set -s escape-time 0
    set -g status-interval 0

    # fix true color
    set-option -ga terminal-overrides ",alacritty:Tc"

    # vim-like pane movement
    bind -r k select-pane -U
    bind -r j select-pane -D
    bind -r h select-pane -L
    bind -r l select-pane -R

    # vim-like window movement
    bind -r H previous-window
    bind -r L next-window

    # better pane splitting
    bind -r v split-window
    bind -r s split-window -h

    bind -T copy-mode    C-c send -X copy-pipe-no-clear "wl-copy"
    bind -T copy-mode-vi C-c send -X copy-pipe-no-clear "wl-copy"

    # styling
    set -g status-bg default
    set -g status-fg white
    set -g status-style fg=white,bg=default

    set -g status-left ${"''"}
    set -g status-right ${"''"}
    set -g status-justify centre
    set -g status-position bottom

    set -g pane-active-border-style bg=default,fg=default
    set -g pane-border-style fg=default

    set -g window-status-current-format "#[fg=cyan]#[fg=black]#[bg=cyan]#I #[bg=brightblack]#[fg=white] #W#[fg=brightblack]#[bg=default] "
    set -g window-status-format "#[fg=magenta]#[fg=black]#[bg=magenta]#I #[bg=brightblack]#[fg=white] #W#[fg=brightblack]#[bg=default] "
  '';
}

