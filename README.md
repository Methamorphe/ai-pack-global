# AI Global Pack v3.1

Global AI coding setup for **Cursor, Codex and Claude Code**.

It installs only user-level/global configuration and never touches project-local `.cursor`, `.codex`, or `.claude` folders.

## Quick start

```bash
npx @methamorphe/ai-pack-global
```

All three targets are installed by default:

```text
Cursor + Codex + Claude Code
```

Target one tool:

```bash
npx @methamorphe/ai-pack-global --cursor-only
npx @methamorphe/ai-pack-global --codex-only
npx @methamorphe/ai-pack-global --claude-only
```

## Installed layout

```text
~/.cursor/
├── rules/engineering.mdc
├── agents/
└── skills/

~/.codex/
├── rules/engineering.md
├── agents/
└── skills/

~/.claude/
├── CLAUDE.md
├── agents/
└── skills/
```

If `CLAUDE_CONFIG_DIR` is set, Claude Code files are installed there instead of `~/.claude`.

## Claude Code integration

The global engineering instructions are inserted into a managed section of `~/.claude/CLAUDE.md`, preserving content outside the AI Pack markers.

Shared `SKILL.md` files are installed directly into `~/.claude/skills/`.

Claude-specific subagent definitions are installed into `~/.claude/agents/` using Claude Code's native frontmatter. The `researcher` agent uses Haiku with low effort to keep broad exploration fast and token-efficient; architecture/debug/review agents use isolated contexts with task-appropriate effort.

## Included agents

- researcher
- architect
- debugger
- reviewer
- ui-designer
- visual-reviewer

## Included skills

- architecture
- deep-debug
- code-review
- security-review
- performance-review
- dependency-research
- project-bootstrap
- frontend-design
- design-system
- ui-audit
- responsive-design
- accessibility
- motion-design
- visual-refinement
- context-optimizer
- context-report

## Context/token optimization

The global rule emphasizes:

- progressive repository disclosure
- targeted reads before broad exploration
- filtered command/log output
- subagents only when isolation/parallelism helps
- fresh threads for unrelated tasks
- targeted verification first

For Claude Code specifically, the installed instructions also recommend `/context` when diagnosing context usage and `/compact` when continuing the same long-running task.

## Safety / existing config

Existing files are preserved unless `--force` is used.

Before replacement, backups are stored under:

```text
~/.ai-global-backups/<timestamp>/
```

Claude's global `CLAUDE.md` is merged using managed markers rather than replaced wholesale.

## Options

```text
--cursor-only
--codex-only
--claude-only
--force
--dry-run
--no-backup
--symlink
--copy
```

`--symlink` applies to rules, agents and skills. The managed Claude `CLAUDE.md` section is written normally so existing personal instructions can coexist.

## Uninstall

```bash
npx @methamorphe/ai-pack-global uninstall
```

Or only Claude Code:

```bash
npx @methamorphe/ai-pack-global uninstall --claude-only
```

The Claude uninstaller removes only the managed AI Pack section from `CLAUDE.md` and the known installed agents/skills.

## Development

```bash
npm run check
npm run pack:dry-run
```

## License

MIT
