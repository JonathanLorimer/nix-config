{tmuxPlugins}: {
  enable = true;
  baseIndex = 1;
  historyLimit = 5000;
  plugins = with tmuxPlugins; [
    cpu
    battery
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
    bind -r v split-window -c "#{pane_current_path}"
    bind -r s split-window -h -c "#{pane_current_path}"

    bind -T copy-mode    C-c send -X copy-pipe-no-clear "wl-copy"
    bind -T copy-mode-vi C-c send -X copy-pipe-no-clear "wl-copy"

    set -g status-left ${"''"}
    set -g status-right ${"''"}
    set -g status-justify centre
    set -g status-position bottom

    set -g pane-active-border-style bg=default,fg=default
    set -g pane-border-style fg=default

    set -g window-status-separator '  '
    set -g window-status-current-format "#[fg=black]#[bg=cyan] #I #[bg=black]#[fg=white] #W "
    set -g window-status-format "#[fg=black]#[bg=magenta] #I #[bg=black]#[fg=white] #W "
    set -g status-bg default
    set-option -g status-style bg=default
  '';
}
