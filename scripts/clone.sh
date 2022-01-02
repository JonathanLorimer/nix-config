DIR=$1
REPO=$2

REPO_DIR="$DIR/$(basename "$REPO").git"

cd "$DIR"
gh repo clone "$REPO" -- --bare
cd "$REPO_DIR"

BRANCH=$(git branch -a | sk | tr -d "+ * ")

git worktree add "./$BRANCH" "$BRANCH"

echo "created worktree at branch: $REPO_DIR/$BRANCH"

