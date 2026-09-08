---
name: context-optimizer
description: Use for large repositories, long-running tasks, token-heavy exploration, or when context efficiency materially affects performance. Do not invoke for trivial tasks.
---

# Context Optimizer

Optimize for useful context, not maximum context.

## Exploration

Use progressive disclosure:

1. Search.
2. Read relevant symbols/ranges.
3. Expand only when evidence requires it.

Avoid loading:
- generated files
- builds
- dependencies
- lockfiles unless relevant
- large logs
- snapshots
- fixtures
- assets
- coverage
- irrelevant docs

## Subagents

Use isolated subagents when:
- exploration touches many files
- shell output is verbose
- research can be compressed before returning
- independent analysis is valuable

Do not fan out multiple agents unnecessarily.

Subagents consume their own tokens.

## Compression

After exploration retain only:
- relevant files
- important symbols
- constraints
- decisions
- unresolved questions

Discard raw search noise.

## Shell/tests

Prefer targeted commands first.

Filter logs and command output.

Escalate to broader verification before completion when appropriate.

## Long tasks

When context accumulates obsolete history:
- persist durable state in project docs when available
- start a fresh thread for a substantially different task
- avoid carrying unrelated past work

## Docs

Load only the documentation needed to resolve a material uncertainty.

## Diff

Inspect affected diff rather than rereading entire files after every edit.

## Output

Keep intermediate summaries compressed and execution-focused.
