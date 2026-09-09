# AI Global Pack v3.2

Global AI coding setup for **Cursor, Codex, Claude Code and VS Code / GitHub Copilot**.

It installs only user-level/global configuration and never touches project-local configuration.

## Quick start

```bash
npx @methamorphe/ai-pack-global@latest
```

All four targets are installed by default:

```text
Cursor + Codex + Claude Code + GitHub Copilot
```

Target one tool:

```bash
npx @methamorphe/ai-pack-global@latest --cursor-only
npx @methamorphe/ai-pack-global@latest --codex-only
npx @methamorphe/ai-pack-global@latest --claude-only
npx @methamorphe/ai-pack-global@latest --copilot-only
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

~/.copilot/
├── instructions/
│   └── engineering.instructions.md
├── agents/
└── skills/
```

If `CLAUDE_CONFIG_DIR` is set, Claude Code files are installed there instead of `~/.claude`.

## GitHub Copilot / VS Code integration

VS Code discovers user-level Copilot customizations from `~/.copilot`:

- `~/.copilot/instructions/*.instructions.md` for personal instructions across workspaces
- `~/.copilot/agents/*.agent.md` for reusable custom agents
- `~/.copilot/skills/*/SKILL.md` for Agent Skills

The engineering instruction uses `applyTo: "**"` so the global engineering/context rules apply across workspaces. Shared Agent Skills are reused directly because VS Code/Copilot supports the Agent Skills standard.

Included Copilot agents:

- Researcher
- Architect
- Debugger
- Reviewer
- UI Designer
- Visual Reviewer

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

The global rules emphasize progressive repository disclosure, targeted reads, filtered command output, isolated agents only when useful, fresh threads for unrelated tasks, and targeted verification first.

## Safety / existing config

Existing files are preserved unless `--force` is used. Before replacement, backups are stored under:

```text
~/.ai-global-backups/<timestamp>/
```

Claude's global `CLAUDE.md` is merged using managed markers rather than replaced wholesale.

## Options

```text
--cursor-only
--codex-only
--claude-only
--copilot-only
--force
--dry-run
--no-backup
--symlink
--copy
```

## Uninstall

```bash
npx @methamorphe/ai-pack-global@latest uninstall
```

Or only GitHub Copilot:

```bash
npx @methamorphe/ai-pack-global@latest uninstall --copilot-only
```

## Development

```bash
npm run check
npm run pack:dry-run
```

## License

MIT
