# Codex Orchestrator Template

Use this template when creating the main orchestrator skill inside a generated harness.

## Required sections

```markdown
# <Harness Name>

## Purpose

State what the harness is for and what final artifact it produces.

## Inputs

- target project or domain
- user goal
- constraints
- delegation permission state

## Outputs

- final artifact path(s)
- intermediate artifact path(s)
- validation summary

## Routing

Explain which specialists exist, what each owns, and when each is used.

## Delegation policy

- stay local by default
- only spawn agents when the user explicitly asked for delegation
- keep immediate blocking tasks local

## Artifact contract

- intermediate directory
- file naming convention
- merge strategy

## Validation

- structural checks
- dry-run prompt(s)
- runtime or test commands when relevant
```

## Artifact conventions

Use deterministic paths so later sessions can resume work:

- intermediate directory: `_workspace/`
- suggested file pattern: `<phase>_<role>_<artifact>.md`
- final output directory: user-specified path or package-local `skills/...`

Examples:

- `_workspace/01_analyst_requirements.md`
- `_workspace/02_architect_pattern-choice.md`
- `_workspace/03_writer_plugin-manifest.json`

## Delegation pseudocode

```text
1. Inspect the project locally.
2. Decide whether the next step is blocking.
3. If blocking, do it locally.
4. If non-blocking and the user explicitly allowed delegation:
   - spawn one worker per disjoint subtask
   - give each worker a clear file or module ownership boundary
5. Continue local work while workers run.
6. Wait only when a worker result becomes critical-path.
7. Integrate outputs.
8. Validate and summarize.
```

## Failure handling

- Retry one time when a worker or command fails for transient reasons.
- If the retry fails, continue with a clearly labeled gap when safe.
- Do not discard conflicting outputs; record the disagreement and choose one with justification.
- If a worker changed overlapping files unexpectedly, stop and reconcile before proceeding.

## Role document template

When you want durable role definitions, store one markdown file per role and keep it brief:

```markdown
# <Role Name>

## Mission

One paragraph on what this role owns.

## Inputs

List the files, artifacts, or questions it consumes.

## Outputs

List the files or decisions it must produce.

## Boundaries

State what this role must not edit or decide.

## Validation

State how its output is checked.
```
