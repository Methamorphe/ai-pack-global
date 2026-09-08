---
name: context-report
description: Explicitly audit a repository for AI context waste and produce safe ignore/context recommendations. Use manually when optimizing a repository.
disable-model-invocation: true
---

# Context Report

Audit repository context efficiency.

Identify:
- generated code
- compiled output
- caches
- dependencies
- large fixtures
- logs
- snapshots
- generated docs
- exports/dumps
- large assets
- duplicate source trees
- legacy areas
- vendored code

Return:

## Safe to ignore
Paths generally safe to exclude.

## Conditionally ignore
Paths useful only for specific workflows.

## Must retain
Important source-of-truth/config/schema/docs.

## Suggested `.cursorignore`
Produce a ready-to-use file.

Do not ignore a file merely because it is large if it is an important source of truth.
