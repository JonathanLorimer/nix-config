{ pkgs }:
let s = name: text: pkgs.writeText {
  inherit name text;
  checkPhase = "${pkgs.shellcheck}/bin/shellcheck ./";
};
in with builtins; [
# TODO: git clone a bare repo, worktree init, then create a directory for the default branch
# TODO: fuzzy find for Code directory
# TODO: fuzzy find for Work directory
# TODO: fuzzy find for git branch sorted by date, and either start a tmux session or add branch dir as window (Add a tmux shortcut for this)
]
