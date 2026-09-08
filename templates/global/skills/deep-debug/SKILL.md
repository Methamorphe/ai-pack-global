---
name: deep-debug
description: Use for difficult, uncertain, intermittent, or root-cause debugging. Do not invoke for obvious syntax errors or straightforward failures with an established cause.
---

# Deep Debug

1. Define actual and expected behavior.
2. Establish reproduction conditions.
3. Trace the execution path.
4. Generate a small ranked hypothesis set.
5. Gather evidence.
6. Eliminate disproven hypotheses.
7. Identify root cause.
8. Implement the smallest robust correction.
9. Add regression coverage when practical.
10. Verify original failure and nearby behavior.

Do not patch symptoms or use arbitrary sleeps/retries without evidence.
