---
description: Interactively kick off a research → design → plan → implement subagent chain from a high-level directive
---

# RDPI Chain

When the user asks you to run an "rdpi" chain or "research, design, plan, implement" workflow for a directive, do the following **before** invoking anything:

1. Read the directive carefully and reason about what each stage needs to accomplish.
2. Draft a specific task string for each stage:
   - **research**: What concrete questions, files, APIs, patterns, or external docs need to be gathered to understand the problem space?
   - **design**: Given the research, what architectural decisions, interfaces, data shapes, or component boundaries need to be worked out?
   - **plan**: What is the ordered sequence of implementation steps, broken into verifiable stages?
   - **implement**: What specific changes should be made, in what order, guided by the plan?
3. Present the four proposed tasks to the user and ask for confirmation or corrections.
4. Once confirmed, invoke the chain:

```
/chain research[output=research.md] "<research task>" -> design[reads=research.md,output=design.md] "<design task>" -> plan[reads=design.md,output=plan.md] "<plan task>" -> implement[reads=plan.md] "<implement task>"
```

Do not skip the confirmation step. The goal is for the user to see and adjust the per-stage framing before any agent runs.
