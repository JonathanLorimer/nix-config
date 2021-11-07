DIR_PATH=$1
NEW_SESSION_NAME=$2

SKIM_DIRS=$(\
  find "$DIR_PATH/" -maxdepth 1 -mindepth 1 -type d \
  | xargs -n 1 basename \
  | sk --preview "echo {} | tr -d \"'\" | cat <(echo -n "$DIR_PATH/") - | xargs ls"\
)

sanitize(){
  echo "$(echo $1 | tr \"./\" \"__\")"
}

DESTINATION="$SKIM_DIRS"
TMUX_DESTINATION=$(sanitize "$DESTINATION")

# TODO: implement correct behaviour if user is already inside of a session called CODE
for SESSION in $(tmux ls -F "#{session_attached}:#{session_name}:#{window_name}"); do
  IS_ATTACHED=$(awk -F: '{print $1}' <<< $SESSION)
  SESSION_NAME=$(awk -F: '{print $2}' <<< $SESSION)
  WINDOW_NAME=$(awk -F: '{print $3}' <<< $SESSION)
  if [ "$IS_ATTACHED" = "1" ]
  then
    tmux rename-window -t "$SESSION_NAME:$WINDOW_NAME" "$TMUX_DESTINATION"
    tmux send-keys -t "$SESSION_NAME:$TMUX_DESTINATION" "cd $DIR_PATH/$DESTINATION" C-m "clear" C-m
    exit 0
  fi
done

tmux new -d -s "$NEW_SESSION_NAME"
tmux rename-window -t "$NEW_SESSION_NAME" "$TMUX_DESTINATION"
tmux send-keys -t "$NEW_SESSION_NAME" "cd $DIR_PATH/$DESTINATION" C-m "clear" C-m
tmux attach-session -t "$NEW_SESSION_NAME:$TMUX_DESTINATION"

