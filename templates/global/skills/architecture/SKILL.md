---
name: architecture
description: Use for non-trivial architecture, subsystem changes, meaningful refactors, or greenfield system design. Do not invoke for simple isolated implementation work.
---

# Architecture

Inspect current entry points, responsibilities, abstractions, dependencies, data flow, tests, and compatibility requirements.

For greenfield determine runtime, deployment, persistence, integrations, scale, security boundaries, observability, and testing.

Choose the smallest architecture that satisfies known requirements.

Avoid speculative architecture.

Before implementation establish:
1. constraints/current state
2. component boundaries
3. data/control flow
4. public interfaces
5. persistence model when relevant
6. error strategy
7. security implications
8. migration implications
9. test strategy
