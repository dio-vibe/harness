# Agent Design Patterns for Codex Harnesses

Use this file when choosing a harness architecture or deciding whether work should stay local.

## Execution modes

| Mode | Use when | Codex primitives | Notes |
| --- | --- | --- | --- |
| Local-only | The task is small, tightly coupled, or the user did not ask for delegation | Main agent only | Default and safest mode |
| Local-first with optional specialists | A few bounded side tasks may run in parallel if the user asks for delegation | Main agent plus optional `spawn_agent` | Good default for most engineering harnesses |
| Delegation-heavy | The user explicitly wants parallel agent work and the task decomposes cleanly | `spawn_agent`, `send_input`, `wait_agent` | Only choose when write scopes and ownership can be separated |

## Pattern selection

### Pipeline

Use for sequential work where each stage depends on the previous stage's output.

- Example: inspect repo -> design package -> generate skills -> validate
- Strength: simple artifact flow
- Risk: little parallelism, bottlenecked by the slowest stage

### Fan-out / Fan-in

Use when several independent analyses or implementations can happen in parallel and later merge.

- Example: security review, performance review, and DX review of the same codebase
- Strength: fastest pattern for independent concerns
- Risk: merge pain if ownership overlaps

### Expert pool

Use when the orchestrator only needs one or two specialists depending on what it discovers.

- Example: route to frontend, backend, data, or docs specialist after initial inspection
- Strength: avoids unnecessary spawning
- Risk: weak if routing logic is vague

### Producer / Reviewer

Use when one role creates an artifact and another verifies or critiques it.

- Example: generate a plugin manifest, then QA it against Codex constraints
- Strength: high quality per artifact
- Risk: review becomes shallow if the reviewer sees too much of the producer's reasoning

### Supervisor

Use when a central orchestrator must maintain state, assign work dynamically, and synthesize the final answer.

- Example: a large migration with multiple bounded workers and a shared final report
- Strength: flexible and resilient to surprises
- Risk: orchestration overhead grows quickly

### Hierarchical delegation

Use only for very large programs of work where specialists must themselves route to narrower specialists.

- Example: a domain harness that generates multiple sub-harnesses across a monorepo
- Strength: scales to very large problem spaces
- Risk: expensive, hard to validate, easy to over-engineer

## Agent split criteria

Split roles only when the separation is justified on at least two of these axes:

| Axis | Split when | Keep together when |
| --- | --- | --- |
| Expertise | The specialist needs unique heuristics or tools | The work is generalist and can share one workflow |
| Parallelism | Subtasks are independent and bounded | Tasks depend on constant back-and-forth |
| Context isolation | Smaller isolated context will improve quality | Every role needs most of the same files |
| Reusability | The role can be reused in future workflows | The role is one-off glue |

## Codex-specific constraints

- Keep the immediate blocking task local.
- Only use `spawn_agent` when the user explicitly asked for delegation, sub-agents, or parallel work.
- Avoid multiple workers editing the same files.
- Prefer file-based artifact handoff for large outputs.
- Prefer one orchestrator skill that can run locally and upgrade to delegated mode when allowed.

## Recommended defaults

For a Codex harness MVP:

1. Choose `local-first with optional specialists`.
2. Use `Producer / Reviewer` for generated manifests and skills.
3. Use `Fan-out / Fan-in` only for read-heavy research or clearly disjoint write scopes.
4. Keep final synthesis with the main agent.
