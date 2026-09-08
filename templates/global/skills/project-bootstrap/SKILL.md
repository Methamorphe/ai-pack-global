---
name: project-bootstrap
description: Explicitly bootstrap a new production-grade project with minimal architecture, tooling, tests, security defaults, and documentation.
disable-model-invocation: true
---

# Project Bootstrap

Determine:
- product purpose
- users
- use cases
- frontend/backend needs
- APIs
- persistence
- auth
- integrations
- deployment
- scale
- security

Prefer mature libraries, current stable versions, small dependency surface, and conventional structures.

Avoid premature:
- microservices
- event buses
- CQRS
- generic repositories
- plugin systems
- elaborate abstractions

Configure when relevant:
- strict typing
- lint/format
- tests
- env config
- migrations
- logging
- health checks
- local workflow
- CI
- security defaults

Validate build/start before completion.
