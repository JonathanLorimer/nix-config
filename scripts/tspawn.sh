#!/usr/bin/env bash
# tenant-spawn <name>
#
# Creates a jj workspace in tenants/<name>, rooted on the `base` bookmark,
# and opens a new zellij tab with:
#   - left pane:    opencode (the agent)
#   - right pane: shell for jj diff / log / etc., already cd'd in
#
# Run from the repo root.

set -euo pipefail

NAME="${1:?Usage: tenant-spawn <workspace-name>}"
REPO_ROOT="$(pwd)"
TENANTS_DIR="$REPO_ROOT/tenants"
WORKSPACE_DIR="$TENANTS_DIR/$NAME"

# ── Guards ───────────────────────────────────────────────────────────────────

if [[ ! -d "$TENANTS_DIR" ]]; then
    echo "error: tenants/ not found in $REPO_ROOT" >&2
    exit 1
fi

if [[ ! -d "$REPO_ROOT/.jj" ]]; then
    echo "error: not inside a jj repo (no .jj in $REPO_ROOT)" >&2
    exit 1
fi

if [[ -z "${ZELLIJ:-}" ]]; then
    echo "error: not inside a zellij session" >&2
    exit 1
fi

if [[ -d "$WORKSPACE_DIR" ]]; then
    echo "error: $WORKSPACE_DIR already exists" >&2
    exit 1
fi

# ── jj workspace ─────────────────────────────────────────────────────────────

# workspace add -r base creates a new empty working-copy commit parented on
# the `base` bookmark — no need for a separate `jj new`.
jj workspace add --name "$NAME" -r base "$WORKSPACE_DIR"

# Remove .envrc if present so direnv falls back to the root repo's .envrc,
# which evaluates the flake from the correct location.
rm -f "$WORKSPACE_DIR/.envrc"

# Give the working-copy commit a description so it's identifiable in jj log.
jj --ignore-working-copy -R "$WORKSPACE_DIR" describe -m "wip($NAME):"

echo "workspace: $WORKSPACE_DIR"
echo "change:    $(jj --ignore-working-copy -R "$WORKSPACE_DIR" log -r @ --no-graph -T 'change_id.short(8) ++ " " ++ description')"

# ── zellij tab ───────────────────────────────────────────────────────────────

TAB_NAME="tenant:$NAME"

zellij action new-tab --name "$TAB_NAME"

# Top pane (the one new-tab opens): launch opencode in the workspace dir.
# write-chars + write 10 (newline byte) is the standard CLI idiom for sending
# a command to the focused shell pane.
zellij action write-chars "cd '$WORKSPACE_DIR' && opencode"
zellij action write 10

# Bottom pane: plain shell for inspection (jj diff, log, resolve, etc.).
# --cwd means the shell starts already in the right directory.
zellij action new-pane \
    --direction left \
    --name "jj"

zellij action write-chars "cd '$WORKSPACE_DIR'"
zellij action write 10
