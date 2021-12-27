{ pkgs }:
let
    s = pkgs.writeShellScriptBin;
    t = name: text: pkgs.writeTextFile
          {
            inherit name text;
            executable = true;
            checkPhase = ''
              ${pkgs.shellcheck}/bin/shellcheck -s bash $out
            '';
          };
    launcher = t "launcher" (builtins.readFile ./launcher.sh);
in [
  (s "code" "${launcher} $HOME/$CODE_DIR CODE")
  (s "work" "${launcher} $HOME/$WORK_DIR WORK")
# TODO: git clone a bare repo, worktree init, then create a directory for the default branch
# TODO: fuzzy find for git branch sorted by date, and either start a tmux session or add branch dir as window (Add a tmux shortcut for this)
]
