---
allowed-tools:
  - type: read_file
    pattern: "**/.claude/conventional-commits.md"
  - type: bash
    pattern: "jj diff --from @- --to @ --no-pager"
description: Observe code diff and come up with a semantic commit message
---

You are tasked with comming up with a commit message for the work contained in the current diff.
You can check the current diff by running `jj diff --from @- --to @ --no-pager`. Please use any
existing context from implementing this feature to help guide the commit message.

Consult ~/.claude/conventional-commits.md and use this as a style guide for top level commit messages.
