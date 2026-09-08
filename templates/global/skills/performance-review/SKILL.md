---
name: performance-review
description: Use when there is a real performance concern, scaling requirement, latency problem, or meaningful risk of CPU/memory/database/network/rendering regression. Do not optimize speculatively.
---

# Performance Review

Establish workload and bottleneck before optimizing.

Backend:
- queries/indexes/N+1
- IO
- allocations
- blocking
- serialization
- payloads
- external calls

Frontend:
- renders
- network waterfalls
- bundles
- hydration
- layout shifts
- assets

Prefer measurable improvements.
Avoid caching/concurrency complexity without justification.
