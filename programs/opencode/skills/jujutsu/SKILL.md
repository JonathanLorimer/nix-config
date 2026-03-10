---
name: jujutsu
description: >
  Version control instructions for Jonathan's workflow using jujutsu (jj) exclusively.
  Use this skill for ANY version control task — commits, branches, history, rebasing,
  pushing, merging, reviewing changes, or navigating a repo. Jonathan does NOT use git
  directly; all VCS operations must use jj commands. Trigger this skill whenever the
  user asks about commits, branches, history, diffs, pushing code, reviewing changes,
  undoing changes, or any other version control operation.
---

# Jujutsu (jj) Version Control Skill

Jonathan uses **jujutsu (`jj`)** exclusively for version control. Never suggest raw `git`
commands — all VCS operations go through `jj`. When in doubt, suggest `jj` equivalents.

---

## Core Mental Model

Jujutsu differs from git in key ways:

- **Every working-copy state is a commit** — there is no "index" or "staging area". The
  working copy is always commit `@`.
- **Changes are first-class** — jj tracks "changes" (identified by `change_id`) separately
  from commits (`commit_id`). A change survives rewrites; its commit hash changes.
- **Conflicts are values** — jj can commit conflict states and resolve them later; it never
  blocks you with unresolved conflicts.
- **No detached HEAD confusion** — `jj edit <rev>` moves `@` to any commit for editing.

---

## Jonathan's Config & Aliases

### Revset aliases (defined in config)
| Alias | Meaning |
|---|---|
| `bases` | `present(bookmarks(exact:base))` or `trunk()` — the integration branch |
| `working_lineage` | All commits from `bases` to `@` and forward |
| `base_branches` | Bookmarks in `bases::` that are mine |
| `base_heads` | Heads of `bases::` that are mine |
| `base_roots` | Roots of `bases::` that are mine (excluding bases) |
| `base_to_branch(target)` | Commits from bases to a named bookmark (exclusive) |

### Shell aliases
| Alias | Expands to | Purpose |
|---|---|---|
| `jj l` | `jj log` | Default log (uses custom revset: `@ \| bases \| working_lineage \| ...`) |
| `jj ll` | `jj log -r all() -n 10` | Last 10 commits, all branches |
| `jj lc` | `jj log -r ::@ -n 10` | Last 10 ancestors of `@` |
| `jj s` | `jj status` | Working copy status |
| `jj f` | `jj git fetch` | Fetch from remote |
| `jj b` | `jj edit -r @-` | Move to parent commit |
| `jj n` | `jj edit -r @+` | Move to child commit |
| `jj cleanup` | `jj abandon bases:: ~ bases & empty()` | Abandon empty descendants of base |
| `jj rb` | `jj rebase -s base -d trunk()` | Rebase base bookmark onto trunk |
| `jj lm` | `jj log -r "heads(mine())" --no-graph -n 10` | My recent head commits |
| `jj nil` | `jj describe -m "∅"` | Mark commit as empty/nil placeholder |

### UI
- Pager: `delta`
- Diff editor: `meld`
- Diff formatter: `:git` (git-style diffs)
- Default command: `jj l` (just run `jj` with no args)

---

## Common Operations

### Viewing history
```sh
jj l                        # Jonathan's custom log view
jj ll                       # All branches, last 10
jj lc                       # Ancestors of @, last 10
jj lm                       # My recent heads, no graph
jj log -r 'all()'           # Full history
jj show                     # Show current commit diff
jj show <rev>               # Show a specific commit
```

### Making changes
```sh
# Just edit files — working copy is always a commit.
# No staging needed.
jj describe -m "message"    # Set commit message for @
jj new                      # Create new empty child commit (moves @ forward)
jj new <rev>                # Create child of a specific commit
jj new <rev1> <rev2>        # Create merge commit
```

### Navigating commits
```sh
jj b                        # Go to parent (@-)
jj n                        # Go to child (@+)
jj edit <rev>               # Move @ to any commit for editing
jj next                     # Move @ to next commit in log order
jj prev                     # Move @ to previous commit
```

### Undoing / fixing mistakes
```sh
jj undo                     # Undo last operation (very safe — op log backed)
jj op log                   # View operation log
jj op restore <op-id>       # Restore to any previous operation state
jj abandon <rev>            # Abandon (drop) a commit
jj cleanup                  # Abandon all empty descendants of bases
```

### Rebasing & restructuring
```sh
jj rebase -r @ -d <dest>           # Rebase current commit onto dest
jj rebase -s <src> -d <dest>       # Rebase src and all descendants onto dest
jj rebase -b <branch> -d <dest>    # Rebase a whole branch
jj rb                              # Rebase base bookmark onto trunk()
jj squash                          # Squash @ into its parent
jj squash -r <rev>                 # Squash specific rev into parent
jj squash --from <rev> --into <dest>  # Squash one commit into another
```

### Splitting & moving changes
```sh
jj split                    # Interactively split @ into two commits
jj split -r <rev>           # Split a specific commit
jj move --from <rev> --to <rev>   # Move changes between commits
jj restore --from <rev> <path>    # Restore file(s) from another revision
```

### Bookmarks (≈ git branches)
```sh
jj bookmark list            # List all bookmarks
jj bookmark create <name>   # Create bookmark at @
jj bookmark create <name> -r <rev>  # Create at specific rev
jj bookmark set <name>      # Move bookmark to @
jj bookmark set <name> -r <rev>    # Move to specific rev
jj bookmark delete <name>   # Delete bookmark
jj bookmark track <remote>/<name>  # Track remote bookmark
```

### Remote operations
```sh
jj f                        # Fetch (jj git fetch)
jj git fetch --remote origin
jj git push                 # Push bookmarks
jj git push -b <bookmark>   # Push specific bookmark
# Note: push-new-bookmarks = false in config, so new bookmarks need explicit push
```

### Resolving conflicts
```sh
jj status                   # See conflicted files
jj resolve                  # Open meld to resolve conflicts interactively
jj resolve --list           # List conflicted files
# After resolving, jj auto-detects resolution — no 'git add' needed
```

### Diffs
```sh
jj diff                     # Diff working copy vs parent
jj diff -r <rev>            # Diff of a specific commit
jj diff --from <rev> --to <rev>   # Diff between two revs
jj diff <path>              # Diff specific path
# Diff editor (meld) opens automatically for interactive diffs via jj split/move
```

---

## Revset Syntax (quick reference)

```
@                   # Working copy
@-                  # Parent of @
@+                  # Child of @
trunk()             # Default remote branch (main/master)
mine()              # Commits authored by me
heads(x)            # Commits in x with no children in x
roots(x)            # Commits in x with no parents in x
x::y                # All commits from x to y (inclusive)
x::                 # x and all descendants
::x                 # x and all ancestors
x & y               # Intersection
x | y               # Union
x ~ y               # Difference (x minus y)
present(x)          # x if it exists, else empty (no error)
bookmarks(pattern)  # Commits pointed to by matching bookmarks
description(glob)   # Commits whose description matches glob
```

---

## Workflow Patterns

### Starting new work
```sh
jj f                        # Fetch latest
jj new bases -m "feat: ..."  # Start from base/trunk
# ... edit files ...
jj describe -m "final message"
jj git push -b <my-bookmark>
```

### Amending the current commit
```sh
# Just edit files — @ updates automatically.
# To update the message:
jj describe
```

### Inserting a commit in history
```sh
jj new <parent-rev>         # Create new commit as child of parent
# ... make changes ...
jj rebase -s <original-children> -d @   # Rebase children onto new commit
```

### Cleaning up before push
```sh
jj cleanup                  # Remove empty commits
jj squash                   # Squash WIP commits if needed
jj l                        # Review final state
```

### Handling "detached" state (non-issue in jj)
Unlike git, jj has no detached HEAD. `jj edit <rev>` is always safe.

---

## GPG Signing
Commits are GPG-signed on push (sign-on-push = true). Key is `jonathan_lorimer@mac.com`.
No action needed — signing is automatic.

---

## Notes on git interop
Jonathan's repo uses `jj git` for remote operations. The underlying git repo is managed by jj.
- Never run raw `git commit`, `git add`, `git checkout`, etc.
- `jj git fetch` / `jj git push` are the only git-interop commands needed.
- `jj git import` / `jj git export` exist if manual sync is ever needed.
