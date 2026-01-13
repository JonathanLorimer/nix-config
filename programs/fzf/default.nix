{
  pkgs,
  colorscheme,
}: let
  # Map base16 colors to fzf color scheme
  colors = {
    fg = colorscheme.base05;
    bg = colorscheme.base00;
    hl = colorscheme.base0D;
    "fg+" = colorscheme.base07;
    "bg+" = colorscheme.base01;
    "hl+" = colorscheme.base0D;
    info = colorscheme.base0A;
    prompt = colorscheme.base0D;
    pointer = colorscheme.base0E;
    marker = colorscheme.base0B;
    spinner = colorscheme.base0C;
    header = colorscheme.base0D;
  };

  # Fuzzy directory finder - echoes selected path
  fzf-cd = pkgs.writeShellScriptBin "fzf-cd" ''
    ${pkgs.fd}/bin/fd --type d --hidden --exclude .git \
      | ${pkgs.fzf}/bin/fzf --preview '${pkgs.eza}/bin/eza -la --color=always {}'
  '';

  # Browse jj operation log snapshots and diff between operations
  jj-op-snapshot = pkgs.writeShellScriptBin "jj-op-snapshot" ''
    set -euo pipefail

    # Get snapshot operations with format: op_id parent_id time description
    # This allows diffing between an operation and its parent
    selected=$(jj op log --no-graph \
      -T 'if(description.contains("snapshot"), id.short() ++ " " ++ parents.map(|p| p.id().short()).join(",") ++ " " ++ time.start().ago() ++ " " ++ description ++ "\n")' \
      | ${pkgs.fzf}/bin/fzf --preview 'jj op diff --from {2} --to {1} --stat' \
      | ${pkgs.gawk}/bin/awk '{print $1, $2}')

    if [[ -n "$selected" ]]; then
      op_id=$(echo "$selected" | ${pkgs.gawk}/bin/awk '{print $1}')
      parent_id=$(echo "$selected" | ${pkgs.gawk}/bin/awk '{print $2}')
      jj op diff --from "$parent_id" --to "$op_id" -p
    fi
  '';

  # Fuzzy finder for branches I've authored
  jj-my-branches = pkgs.writeShellScriptBin "jj-my-branches" ''
    set -euo pipefail

    jj log --no-graph -r 'mine() & bookmarks()' \
      -T 'bookmarks.map(|b| b.name() ++ "\n").join("")' \
      | ${pkgs.coreutils}/bin/sort -u \
      | ${pkgs.fzf}/bin/fzf --preview 'jj log -r {}'
  '';
in {
  # fzf program configuration
  config = {
    enable = true;
    enableZshIntegration = true;
    package = pkgs.fzf;

    inherit colors;

    defaultCommand = "${pkgs.fd}/bin/fd --type f --hidden --exclude .git";
    defaultOptions = [
      "--height 40%"
      "--border"
    ];

    # CTRL-T: file widget
    fileWidgetCommand = "${pkgs.fd}/bin/fd --type f --hidden --exclude .git";
    fileWidgetOptions = [
      "--preview '${pkgs.bat}/bin/bat --color=always --style=numbers --line-range=:500 {}'"
    ];

    # ALT-C: directory widget
    changeDirWidgetCommand = "${pkgs.fd}/bin/fd --type d --hidden --exclude .git";
    changeDirWidgetOptions = [
      "--preview '${pkgs.eza}/bin/eza -la --color=always {}'"
    ];

    # CTRL-R: history widget
    historyWidgetOptions = [
      "--sort"
      "--exact"
    ];
  };

  # Scripts to add to home.packages
  scripts = [fzf-cd jj-op-snapshot jj-my-branches];
}
