---
name: harness
description: "Build Codex-native harnesses for a project. Use when the user asks to set up a harness, design an agent workflow, create reusable Codex skills, package a workflow as a plugin, or port a Claude-style harness into Codex."
---

# Harness

Use this skill to design and scaffold a Codex-native harness for a domain or project.

A harness is a reusable package of:

- one orchestrator skill
- zero or more specialist skills
- role definitions or reference docs for specialists
- optional plugin packaging via `.codex-plugin/plugin.json`
- validation guidance so the workflow can be repeated later with less drift

## Codex Mapping

This fork targets Codex rather than Claude Code. Map the original concepts to Codex primitives:

| Original concept | Codex mapping |
| --- | --- |
| `.claude-plugin/plugin.json` | `.codex-plugin/plugin.json` |
| `.claude/skills/...` | `skills/.../SKILL.md` |
| Agent team runtime | Local orchestration plus optional `spawn_agent` delegation |
| `TeamCreate`, `TaskCreate`, `SendMessage` | Main-agent coordination, files, `spawn_agent`, `send_input`, `wait_agent` |
| Claude-only agent definitions | Persistent role docs and orchestrator references inside the generated package |

Do not assume you may spawn agents immediately. Codex only allows delegation when the user explicitly asks for sub-agents, delegation, or parallel agent work. Design the harness so it works locally first and upgrades cleanly to delegated execution later.

Read the pattern catalog before fixing the team shape:
- `references/agent-design-patterns.md` for pattern and execution-mode selection
- `references/orchestrator-template.md` for wiring and artifact contracts
- `references/team-examples.md` for concrete layouts by domain

## Workflow

### Phase 1: Analyze the domain

1. Determine the target project, workflow, and deliverable shape.
2. Inspect the codebase or content domain before inventing roles.
3. Identify repeated work that would benefit from a reusable harness.
4. Detect user sophistication and tune terminology accordingly.
5. Check whether there is already a local plugin, skill, or harness to extend instead of replacing.

### Phase 2: Choose the architecture

1. Break the work into specialist concerns.
2. Choose a pattern from `references/agent-design-patterns.md`.
3. Decide whether the harness is:
   - local-only
   - local-first with optional delegated experts
   - delegation-heavy and only usable when the user explicitly authorizes sub-agents
4. Keep the critical path local if the next step depends on the result immediately.
5. Use delegation only for bounded, non-overlapping, materially useful subtasks.

### Phase 3: Define the package layout

Default to a repo-local plugin package so the harness is reusable and installable:

```text
plugins/<harness-name>/
├── .codex-plugin/plugin.json
├── skills/
│   ├── <orchestrator>/SKILL.md
│   ├── <specialist-a>/SKILL.md
│   └── <specialist-b>/SKILL.md
└── skills/<orchestrator>/references/
    ├── agents/<role>.md
    ├── contracts.md
    └── examples.md
```

If packaging would be unnecessary overhead, generate just the `skills/` tree in the current project. When porting an existing Claude-oriented repo, preserve the original Claude files and add Codex files beside them instead of deleting history.

### Phase 4: Generate Codex-native skills

1. Write concise frontmatter with strong trigger language.
2. Keep `SKILL.md` focused on workflow, routing, and selection logic.
3. Move bulky examples, schemas, and role definitions into `references/`.
4. If the harness should ship as a plugin, create `.codex-plugin/plugin.json`.
5. Reuse the guidance in `references/skill-writing-guide.md`.

### Phase 5: Define orchestration

1. Define the orchestrator's responsibilities, decision points, and output contracts.
2. State when the harness stays local and when it may delegate.
3. Define artifact paths for intermediate outputs so integration is deterministic.
4. Add failure-handling rules. Retry once when practical, then continue with an explicit gap report.
5. Use `references/orchestrator-template.md` for the exact section structure.

### Phase 6: Validate the harness

1. Validate JSON and frontmatter.
2. Check that every reference named in `SKILL.md` actually exists.
3. Run at least one dry-run prompt against the generated harness.
4. Where possible, compare baseline execution versus harness-guided execution.
5. Use `references/skill-testing-guide.md`.

## Required outputs

Produce these artifacts unless the user explicitly narrows scope:

- one orchestrator skill
- at least one domain-specific skill or role reference
- a package layout decision
- a validation plan
- a short explanation of how the harness maps to Codex execution rules

If the user asks for a reusable distribution, also produce:
- `.codex-plugin/plugin.json`
- plugin interface metadata
- starter prompts
- any required assets or references

## Guardrails

- Do not invent Codex capabilities that do not exist.
- Do not write a delegation-heavy harness if the user did not ask for delegation.
- Do not create specialist roles that overlap heavily in ownership.
- Do not bury required instructions in missing reference files.
- Do not produce large auxiliary docs outside the skill system unless the user asked for them.

## When to read references

- Read `references/agent-design-patterns.md` when choosing a team shape or deciding local vs delegated execution.
- Read `references/orchestrator-template.md` when writing the orchestrator skill or artifact contracts.
- Read `references/team-examples.md` when you need concrete domain examples.
- Read `references/skill-writing-guide.md` when drafting generated skills or plugin layout.
- Read `references/skill-testing-guide.md` when validating triggers and dry runs.
- Read `references/qa-agent-guide.md` when the harness includes QA or review responsibilities.

End each harness build with:
1. package shape
2. specialist list
3. orchestration pattern
4. validation approach
5. concrete generated files

## Final checklist

- confirm the chosen architecture and why it fits
- confirm the generated paths exist
- confirm the harness can run locally
- confirm delegation is clearly optional or explicitly required
- confirm at least one dry-run prompt and validation path are documented
