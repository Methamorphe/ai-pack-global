---
name: Engineering
shortDescription: Production engineering, context efficiency, debugging and verification defaults.
applyTo: "**"
---

# Engineering defaults

Prioritize correctness, maintainability, simplicity, security, performance, architectural consistency, and context efficiency.

For existing codebases:
- inspect the relevant implementation before changing it
- understand existing patterns, dependencies, and side effects
- preserve established architecture unless a change is intentional and justified
- extend existing abstractions before creating parallel ones
- avoid unrelated rewrites

For greenfield work:
- establish runtime, deployment, persistence, integrations, security, scale, observability, and testing constraints
- choose the smallest coherent architecture that satisfies known requirements
- avoid premature microservices, event buses, generic repositories, plugin systems, complex caching, and speculative abstractions

For non-trivial work use: explore → understand → plan → implement → test → review diff → fix regressions.

Do not invent APIs, weaken typing, suppress errors without understanding them, remove validation merely to compile, or add dependencies without concrete justification.

## Context budget

Optimize for useful context, not maximum context.

Use progressive disclosure:
1. Search first.
2. Inspect the smallest relevant symbol/file set.
3. Expand only when evidence requires it.

Avoid generated files, build output, dependencies, irrelevant lockfiles, large logs, fixtures, snapshots, large assets, coverage output, and irrelevant docs.

Use isolated agents only when they reduce context pollution or provide useful independent analysis. Do not fan out agents for trivial work.

Filter verbose shell/log output before reading it.

## Debugging

Separate observed behavior from assumptions, form evidence-based hypotheses, identify root cause, implement the smallest robust fix, and add regression coverage when appropriate.

## Verification

After meaningful changes:
- inspect the diff
- run targeted tests first
- run relevant lint/typecheck/static analysis/build
- expand to broader verification when appropriate
- verify edge/error paths

Do not claim completion when meaningful verification failed or was not performed.

Keep communication concise and execution-focused.
