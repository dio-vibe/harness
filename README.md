<p align="center">
  <img src="harness_banner.png" alt="Harness Banner" width="600">
</p>

<p align="center">
  <img src="https://img.shields.io/badge/Version-1.1.0-brightgreen.svg" alt="Version">
  <a href="LICENSE"><img src="https://img.shields.io/badge/License-Apache_2.0-blue.svg" alt="License"></a>
  <img src="https://img.shields.io/badge/Codex-Plugin-orange.svg" alt="Codex Plugin">
  <img src="https://img.shields.io/badge/Patterns-6_Architectures-orange.svg" alt="6 Architecture Patterns">
  <img src="https://img.shields.io/badge/Mode-Local_First_%2B_Delegated_Agents-green.svg" alt="Local First and Delegated Agents">
  <a href="https://github.com/revfactory/harness/stargazers"><img src="https://img.shields.io/github/stars/revfactory/harness?style=social" alt="GitHub Stars"></a>
</p>

# Harness

**Agent System & Skill Architect** — A Codex Port of `revfactory/harness`

**English** | [한국어](README_KO.md) | [日本語](README_JA.md)

A meta-skill that designs domain-specific agent teams, defines specialized agents, and generates the skills they use.

This fork keeps the upstream Claude artifacts in place and adds a Codex-native surface beside them:

- `.codex-plugin/plugin.json`
- Codex-aware `skills/harness/SKILL.md`
- bundled `references/` files that the skill actually points to

## Overview

Harness now targets Codex's execution model. Say "build a harness for this project" and it should generate a repo-local plugin or skill package tailored to your domain, with local-first orchestration and optional delegated specialists when the user explicitly asks for sub-agents.

## Key Features

- **Agent Team Design** — 6 architectural patterns: Pipeline, Fan-out/Fan-in, Expert Pool, Producer-Reviewer, Supervisor, and Hierarchical Delegation
- **Skill Generation** — Auto-generates skills with Progressive Disclosure for efficient context management
- **Orchestration** — Inter-agent data passing, error handling, and team coordination protocols
- **Validation** — Trigger verification, dry-run testing, and with-skill vs without-skill comparison tests

## Workflow

```
Phase 1: Domain Analysis
    ↓
Phase 2: Team Architecture Design (Agent Teams vs Subagents)
    ↓
Phase 3: Agent Definition Generation (.claude/agents/)
    ↓
Phase 4: Skill Generation (.claude/skills/)
    ↓
Phase 5: Integration & Orchestration
    ↓
Phase 6: Validation & Testing
```

## Codex Mapping

| Upstream concept | Codex concept |
|------|-------------|
| `.claude-plugin/plugin.json` | `.codex-plugin/plugin.json` |
| `.claude/skills/` | `skills/` |
| Claude agent teams | main-agent orchestration plus optional `spawn_agent` |
| `TeamCreate` / `SendMessage` / `TaskCreate` | local synthesis, file contracts, `spawn_agent`, `send_input`, `wait_agent` |

## Installation

### As a local Codex plugin

Clone or copy this repo where you keep local Codex plugins, then load the plugin from its `.codex-plugin/plugin.json` manifest. If you manage a local marketplace, point its entry at this repository's plugin root.

## Plugin Structure

```
harness/
├── .codex-plugin/
│   └── plugin.json                 # Codex plugin manifest
├── .claude-plugin/
│   └── plugin.json                 # Upstream Claude manifest kept for reference
├── assets/
│   ├── harness_banner.png
│   ├── harness_icon.png
│   └── harness_team.png
├── skills/
│   └── harness/
│       ├── SKILL.md                # Main Codex skill definition
│       └── references/
│           ├── agent-design-patterns.md   # Codex architecture and delegation choices
│           ├── orchestrator-template.md   # Orchestrator template and file contracts
│           ├── team-examples.md           # Example harness layouts
│           ├── skill-writing-guide.md     # Generated skill guidance
│           ├── skill-testing-guide.md     # Validation methodology
│           └── qa-agent-guide.md          # QA role guidance
└── README.md
```

## Usage

Trigger in Codex with prompts like:

```
Build a harness for this project
Design a reusable Codex workflow for this domain
Create a plugin and skills that package this workflow
```

### Execution Modes

| Mode | Description | Recommended For |
|------|-------------|-----------------|
| **Local-first** (default) | Main agent orchestrates and writes artifacts directly | Most coding and packaging work |
| **Delegated specialists** | Main agent spawns bounded workers when the user explicitly requests delegation | Parallel read-heavy or disjoint implementation tasks |

<p align="center">
  <img src="harness_team.png" alt="Harness Agent Team" width="500">
</p>

### Architecture Patterns

| Pattern | Description |
|---------|-------------|
| Pipeline | Sequential dependent tasks |
| Fan-out/Fan-in | Parallel independent tasks |
| Expert Pool | Context-dependent selective invocation |
| Producer-Reviewer | Generation followed by quality review |
| Supervisor | Central agent with dynamic task distribution |
| Hierarchical Delegation | Top-down recursive delegation |

## Output

Files generated by Harness:

```
your-project/
├── plugins/
│   └── your-harness/
│       ├── .codex-plugin/
│       │   └── plugin.json
│       └── skills/
│           ├── orchestrate/
│           │   ├── SKILL.md
│           │   └── references/
│           └── specialist/
│               └── SKILL.md
```

## Use Cases — Try These Prompts

Copy any prompt below into Codex after loading Harness:

**Deep Research**
```
Build a harness for deep research. I need an agent team that can investigate
any topic from multiple angles — web search, academic sources, community
sentiment — then cross-validate findings and produce a comprehensive report.
```

**Website Development**
```
Build a harness for full-stack website development. The team should handle
design, frontend (React/Next.js), backend (API), and QA testing in a
coordinated pipeline from wireframe to deployment.
```

**Webtoon / Comic Production**
```
Build a harness for webtoon episode production. I need agents for story
writing, character design prompts, panel layout planning, and dialogue
editing. They should review each other's work for style consistency.
```

**YouTube Content Planning**
```
Build a harness for YouTube content creation. The team should research
trending topics, write scripts, optimize titles/tags for SEO, and plan
thumbnail concepts — all coordinated by a supervisor agent.
```

**Code Review & Refactoring**
```
Build a harness for comprehensive code review. I want parallel agents
checking architecture, security vulnerabilities, performance bottlenecks,
and code style — then merging all findings into a single report.
```

**Technical Documentation**
```
Build a harness that generates API documentation from this codebase.
Agents should analyze endpoints, write descriptions, generate usage
examples, and review for completeness.
```

**Data Pipeline Design**
```
Build a harness for designing data pipelines. I need agents for schema
design, ETL logic, data validation rules, and monitoring setup that
delegate sub-tasks hierarchically.
```

**Marketing Campaign**
```
Build a harness for marketing campaign creation. The team should research
the target market, write ad copy, design visual concepts, and set up
A/B test plans with iterative quality review.
```

## Built with Harness

### Harness 100

**[revfactory/harness-100](https://github.com/revfactory/harness-100)** — 100 production-ready agent team harnesses across 10 domains, available in both English and Korean (200 packages total). Each harness ships with 4-5 specialist agents, an orchestrator skill, and domain-specific skills — all generated by this plugin. 1,808 markdown files covering content creation, software development, data/AI, business strategy, education, legal, health, and more.

### Research: A/B Testing Harness Effectiveness

**[revfactory/claude-code-harness](https://github.com/revfactory/claude-code-harness)** — A controlled experiment across 15 software engineering tasks measuring the impact of structured pre-configuration on LLM code agent output quality.

| Metric | Without Harness | With Harness | Improvement |
|--------|:-:|:-:|:-:|
| Average Quality Score | 49.5 | 79.3 | **+60%** |
| Win Rate | — | — | **100%** (15/15) |
| Output Variance | — | — | **-32%** |

Key finding: effectiveness scales with task complexity — the harder the task, the greater the improvement (+23.8 Basic, +29.6 Advanced, +36.2 Expert).

> Full paper: *Hwang, M. (2026). Harness: Structured Pre-Configuration for Enhancing LLM Code Agent Output Quality.*

## Requirements

- Codex environment with local plugin support
- Optional: explicit user permission when you want the generated harness to use delegated agents

## License

Apache 2.0
