DIR_PATH=$1
NEW_SESSION_NAME=$2

DESTINATION=$(\
  find "$DIR_PATH/" -maxdepth 1 -mindepth 1 -type d -print0\
  | xargs -0 -n 1 basename \
  | sk --preview "echo {} | tr -d \"'\" | cat <(echo -n ""$DIR_PATH"/") - | xargs ls"\
)

sanitize(){
  echo "$1" | tr \"./\" \"__\"
}

TMUX_DESTINATION=$(sanitize "$DESTINATION")

# Look for existing session with the same name
for SESSION in $(tmux ls -F "#{session_attached}:#{session_name}:#{window_name}"); do
  SESSION_NAME=$(awk -F: '{print $2}' <<< "$SESSION")
  WINDOW_NAME=$(awk -F: '{print $3}' <<< "$SESSION")
  if [ "$SESSION_NAME" = "$NEW_SESSION_NAME" ]
  then
    if [ "$WINDOW_NAME" = "$TMUX_DESTINATION" ]
    then
      tmux attach -t "$SESSION_NAME:$TMUX_DESTINATION"
    else
      tmux new-window -t "$SESSION_NAME" -n "$TMUX_DESTINATION"
      tmux send-keys -t "$SESSION_NAME:$TMUX_DESTINATION" "cd $DIR_PATH/$DESTINATION" C-m "clear" C-m
      if [ -z "$TMUX" ]
      then
        tmux attach -t "$SESSION_NAME:$TMUX_DESTINATION"
      fi
    fi
    exit 0
  fi
done

# Start a new session
tmux new -d -s "$NEW_SESSION_NAME"
tmux rename-window -t "$NEW_SESSION_NAME" "$TMUX_DESTINATION"
tmux send-keys -t "$NEW_SESSION_NAME" "cd $DIR_PATH/$DESTINATION" C-m "clear" C-m
tmux attach -t "$NEW_SESSION_NAME:$TMUX_DESTINATION"

