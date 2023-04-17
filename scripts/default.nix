{pkgs}: let
  s = pkgs.writeShellScriptBin;
  sa = pkgs.writeShellApplication;
  launcher = sa {
    name = "launcher";
    text = builtins.readFile ./launcher.sh;
    runtimeInputs = with pkgs; [skim tmux];
  };
in [
  (s "code" "${launcher}/bin/launcher $HOME/$CODE_DIR CODE")
  (s "work" "${launcher}/bin/launcher $HOME/$WORK_DIR WORK")
  # TODO: fork a git repo, set origin to my fork and upstream to the forked repo
  # TODO: fuzzy find for git branch sorted by date, and either start a tmux session or add branch dir as window (Add a tmux shortcut for this)
]
