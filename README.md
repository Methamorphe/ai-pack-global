# AI Global Pack v3

Global Cursor + Codex engineering setup with context/token optimization.

This package installs only global configuration under `~/.cursor` and `~/.codex`. It never modifies project-local `.cursor/` or `.codex/` folders.

## Quick start

```bash
npx @methamorphe/ai-pack-global
```

Cursor only:

```bash
npx @methamorphe/ai-pack-global --cursor-only
```

Codex only:

```bash
npx @methamorphe/ai-pack-global --codex-only
```

Preview changes:

```bash
npx @methamorphe/ai-pack-global --dry-run
```

Uninstall known managed files:

```bash
npx @methamorphe/ai-pack-global uninstall
```

## Installed globally

### Rules

A production engineering rule covering existing vs greenfield work, architecture discipline, debugging, context budgets, targeted verification, and concise communication.

### Agents

- researcher
- architect
- debugger
- reviewer
- ui-designer
- visual-reviewer

### Skills

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

## Safety / existing config

Existing files are kept by default. Use `--force` to replace managed files; replacements are backed up under `~/.ai-global-backups/` unless `--no-backup` is passed.

## Symlink mode

For normal `npx` usage prefer copy mode. `--symlink` is intended for a persistent local clone because temporary npx directories can be cleaned up.

## Local development

```bash
npm run check
npm run pack:dry-run
```

## Publishing

First public publish:

```bash
npm login
npm publish --access public
```

After the package exists on npm, configure npm Trusted Publishing for this GitHub repository, then publish releases by pushing `v*` tags.

## License

MIT
