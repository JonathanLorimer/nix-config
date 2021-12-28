{ pkgs }:
let
    s = pkgs.writeShellScriptBin;
    sa = pkgs.writeShellApplication;
    launcher = sa {
      name = "launcher";
      text = (builtins.readFile ./launcher.sh);
      runtimeInputs = with pkgs; [ skim tmux ];
    };
    clone = sa {
      name = "clone";
      text = (builtins.readFile ./clone.sh);
      runtimeInputs = with pkgs; [ git ];
    };
in [
  (s "code" "${launcher}/bin/launcher $HOME/$CODE_DIR CODE")
  (s "work" "${launcher}/bin/launcher $HOME/$WORK_DIR WORK")
  (s "clone" "${clone}/bin/clone $HOME/$CODE_DIR $1")
# TODO: git clone a bare repo, worktree init, then create a directory for the default branch
# TODO: fuzzy find for git branch sorted by date, and either start a tmux session or add branch dir as window (Add a tmux shortcut for this)
]
