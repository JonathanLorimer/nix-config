---
allowed-tools: all
description: Pull a Linear ticket, assign to me, move to In Progress, create a jj bookmark, and begin work
---

You are starting work on Linear ticket: $ARGUMENTS

The ticket identifier is the argument above (e.g. "ENG-123"). Execute the following steps in order:

**1. Fetch the ticket**
Use the Linear MCP tools to retrieve the full ticket details — title, description, current state, and assignee.
Display a brief summary to the user: ticket title, current state, and any important context from the description.

**2. Assign and move to In Progress**
Use the Linear MCP tools to:
- Assign the ticket to me (Jonathan Lorimer, jonathanlorimer@pm.me)
- Update the ticket state to "In Progress"

Confirm both updates succeeded before proceeding.

**3. Create a jj bookmark**
Run `jj bookmark create $ARGUMENTS` to create a bookmark named after the ticket identifier at the current revision.
If the bookmark already exists, inform the user and skip creation.

**4. Begin working**
Present the full ticket description and acceptance criteria to the user, then ask: "What would you like to tackle first?" to orient the implementation session.
