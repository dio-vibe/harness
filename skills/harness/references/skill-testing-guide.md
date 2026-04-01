# Skill Testing Guide

Use this guide to validate a generated Codex harness before calling it done.

## 1. Structure checks

- Confirm every referenced path exists.
- Parse `.codex-plugin/plugin.json` as JSON.
- Confirm every generated `SKILL.md` has frontmatter with `name` and `description`.
- Confirm asset paths in the plugin manifest exist.

## 2. Trigger checks

For each generated skill, write 2 or 3 realistic prompts:

- one direct request that should trigger the skill
- one adjacent request that should still trigger it
- one nearby request that should not trigger it

Use these prompts to inspect whether the description is too narrow or too broad.

## 3. Dry-run execution

Run at least one realistic prompt against the harness and verify:

- the orchestrator chooses a sensible pattern
- the skill reads only the needed references
- the produced file layout matches the design
- the final answer explains outcomes and residual risks

## 4. Baseline comparison

When practical, compare:

- unguided execution
- harness-guided execution

Look for improvements in:

- output completeness
- fewer missed edge cases
- clearer file layout
- more deterministic validation

## 5. Regression checks

If the harness was ported from another environment, verify that:

- the Codex version does not reference unavailable primitives
- local-first mode still works without delegation
- the new plugin manifest points to valid Codex paths
