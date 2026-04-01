# QA Role Guide

Use this file when the harness includes a QA or reviewer role.

## Mission

The QA role should verify boundary behavior, integration assumptions, and artifact quality. It is not just a presence check.

## Good QA scope

- compare inputs and outputs across module boundaries
- run focused tests or validation commands when available
- check that generated docs or manifests match the actual file layout
- verify that claims in the final summary are backed by artifacts

## Weak QA patterns to avoid

- only checking that a file exists
- repeating the producer's explanation without independent verification
- reviewing after the very end when incremental checks were possible

## Incremental QA

Prefer checking after each significant milestone:

1. after package layout creation
2. after manifest generation
3. after skill generation
4. after validation wiring

This catches structural drift before the final summary.

## Codex-specific guidance

- If QA needs to execute commands or tests, keep it local unless the user explicitly asked for delegated work.
- If a QA worker is spawned, give it read-heavy scope or a disjoint validation script ownership.
- Report concrete failures with file paths, commands, and expected versus actual behavior.
