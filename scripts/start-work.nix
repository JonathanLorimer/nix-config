{ pkgs }:
pkgs.writeShellScriptBin "start-work" ''
  SESSION="Work"
  WORK_DIR_BE="~/Mercury/mercury-web-backend"
  WORK_DIR_FE="~/Mercury/mercury-web"

  # Re-connect to vpn
  sudo systemctl restart openvpn-mercury

  # Establish sessions and windows
  tmux new-session -d -s "$SESSION"
  tmux rename-window -t 1 'Editor BE' tmux new-window -t "$SESSION:2" -n 'Shell'
  tmux new-window -t "$SESSION:3" -n 'Server'
  tmux new-window -t "$SESSION:4" -n 'DB'
  tmux new-window -t "$SESSION:5" -n 'Editor FE'

  # Setup Editor
  tmux split-window -h -p 30 -t "$SESSION:Editor BE"
  tmux send-keys -t "$SESSION:Editor BE.1" "cd $WORK_DIR_BE; nix-shell --run 'nvim'" C-m
  tmux send-keys -t "$SESSION:Editor BE.2" "cd $WORK_DIR_BE; nix-shell --run 'make ghcid'" C-m

  tmux split-window -h -p 30 -t "$SESSION:Editor FE"
  tmux send-keys -t "$SESSION:Editor FE.1" "cd $WORK_DIR_FE; nix-shell" C-m
  tmux send-keys -t "$SESSION:Editor FE.2" "cd $WORK_DIR_FE; nix-shell" C-m

  # Setup Editor
  tmux send-keys -t "$SESSION:DB" "sudo su - postgres" C-m

  # Setup Server
  tmux send-keys -t "$SESSION:Server" "ssh -l jonathanl 2.mercury-web-backend.production.internal.mercury.com" C-m

  tmux attach -t "$SESSION:Shell"
''
