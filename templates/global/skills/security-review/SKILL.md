---
name: security-review
description: Use for authentication, authorization, payments, secrets, uploads, external input, webhooks, public APIs, or sensitive-data changes. Do not invoke for unrelated ordinary code.
---

# Security Review

Identify trust boundaries first.

Check:
- authentication/session/token handling
- server-side authorization
- ownership/tenant boundaries
- input validation
- injection
- XSS/CSRF/SSRF/CORS
- path traversal
- unsafe deserialization
- secrets
- sensitive logging
- data exposure
- webhook signatures/replay where relevant
- safe failure behavior

Prioritize exploitable issues.
