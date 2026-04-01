# Team Examples for Codex Harnesses

These examples are intentionally small and Codex-oriented. Expand only when the domain justifies the extra roles.

## 1. Deep research harness

- Pattern: Fan-out / Fan-in
- Orchestrator: research lead
- Specialists:
  - source scout
  - contradiction checker
  - report editor
- Default mode: local-first, delegate only the source scout and contradiction checker when the user explicitly requests parallel research
- Output: research report plus source table

## 2. Full-stack delivery harness

- Pattern: Supervisor
- Orchestrator: product engineer
- Specialists:
  - frontend implementer
  - backend implementer
  - QA reviewer
- Default mode: local-first with optional implementation workers
- Output: plugin package or repo changes plus validation notes

## 3. Code review harness

- Pattern: Fan-out / Fan-in
- Orchestrator: review synthesizer
- Specialists:
  - architecture reviewer
  - security reviewer
  - performance reviewer
- Default mode: delegation-friendly because write scope is usually empty
- Output: consolidated findings ordered by severity

## 4. Documentation harness

- Pattern: Producer / Reviewer
- Orchestrator: doc lead
- Specialists:
  - extractor
  - example writer
  - completeness reviewer
- Default mode: local-first
- Output: docs plus example snippets and gap list

## 5. Migration harness

- Pattern: Pipeline
- Orchestrator: migration planner
- Specialists:
  - inventory analyst
  - package architect
  - verifier
- Default mode: local-only until the migration plan is stable
- Output: migration plan, target package layout, and validation checklist
