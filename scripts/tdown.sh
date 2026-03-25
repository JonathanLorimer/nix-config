#!/usr/bin/env bash
# tenant-teardown
#
# fzf-select a workspace from tenants/, forget it from jj, remove the
# directory.
#
# Run from the repo root.

set -euo pipefail

REPO_ROOT="$(pwd)"
TENANTS_DIR="$REPO_ROOT/tenants"

# ── Guards ───────────────────────────────────────────────────────────────────

if [[ ! -d "$TENANTS_DIR" ]]; then
    echo "error: tenants/ not found in $REPO_ROOT" >&2
    exit 1
fi

if [[ ! -d "$REPO_ROOT/.jj" ]]; then
    echo "error: not inside a jj repo" >&2
    exit 1
fi

# ── Build candidate list ──────────────────────────────────────────────────────
# jj workspace list emits lines like:
#   default       : <change-id> <description>
#   tenant-name   : <change-id> <description>
# We filter to names whose directory exists under tenants/.

mapfile -t CANDIDATES < <(
    jj workspace list --no-pager 2>/dev/null \
    | awk '{gsub(/:$/, "", $1); print $1}' \
    | while read -r ws; do
        [[ -d "$TENANTS_DIR/$ws" ]] && echo "$ws"
    done
)

if [[ ${#CANDIDATES[@]} -eq 0 ]]; then
    echo "no tenants to tear down" >&2
    exit 0
fi

# ── fzf selection ────────────────────────────────────────────────────────────

NAME=$(printf '%s\n' "${CANDIDATES[@]}" | fzf \
    --prompt "teardown tenant > " \
    --header "select workspace to destroy" \
    --height=~10 \
    --border)

[[ -z "$NAME" ]] && exit 0   # user cancelled

WORKSPACE_DIR="$TENANTS_DIR/$NAME"

# ── Confirm ───────────────────────────────────────────────────────────────────

echo "workspace : $NAME"
echo "directory : $WORKSPACE_DIR"
echo ""
read -r -p "tear down? [y/N] " CONFIRM
[[ "$CONFIRM" =~ ^[Yy]$ ]] || exit 0

# ── jj + filesystem ──────────────────────────────────────────────────────────

jj workspace forget "$NAME"
rm -rf "$WORKSPACE_DIR"

echo "torn down: $NAME"
