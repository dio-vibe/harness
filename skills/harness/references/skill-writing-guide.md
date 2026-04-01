# Skill Writing Guide for Generated Codex Harnesses

Use this guide when the harness generates one or more skills.

## Naming

- Use concise kebab-case folder names.
- Keep the frontmatter `name` aligned with the folder purpose.
- Prefer role or workflow names over vague labels like `helper` or `tool`.

## Frontmatter

Every `SKILL.md` needs:

```yaml
---
name: my-skill
description: Clear trigger language that says what the skill does and when to use it.
---
```

The description is the trigger surface. It should say both:
- the capability
- the situations that should cause Codex to use it

## Body structure

Keep the body focused on:

1. what the skill is for
2. how to decide whether it applies
3. the default workflow
4. guardrails
5. which reference files to read and when

Move detailed schemas, examples, and templates to `references/`.

## Recommended package layout

```text
plugins/<plugin-name>/
├── .codex-plugin/plugin.json
└── skills/
    ├── <skill-a>/SKILL.md
    └── <skill-b>/
        ├── SKILL.md
        └── references/
```

## Prompting style

- Explain the reason behind important rules.
- Keep instructions concrete and operational.
- Avoid speculative or unsupported tool flows.
- Prefer durable workflows over narrow one-off prompts.

## Good generated skill checklist

- The description is specific and triggerable.
- The body is short enough to scan quickly.
- Every referenced file exists.
- The skill can run locally.
- Delegation is optional and explicitly gated when needed.
- Validation is part of the workflow, not an afterthought.
