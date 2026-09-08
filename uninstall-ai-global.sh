#!/usr/bin/env bash
set -euo pipefail

HOME_DIR="${HOME:?HOME not set}"
CLAUDE_HOME="${CLAUDE_CONFIG_DIR:-$HOME_DIR/.claude}"
CURSOR=1
CODEX=1
CLAUDE=1
DRY=0

usage(){ echo "Usage: ./uninstall-ai-global.sh [--cursor-only|--codex-only|--claude-only|--dry-run]"; }

while [[ $# -gt 0 ]]; do
  case "$1" in
    --cursor-only) CURSOR=1; CODEX=0; CLAUDE=0; shift ;;
    --codex-only) CURSOR=0; CODEX=1; CLAUDE=0; shift ;;
    --claude-only) CURSOR=0; CODEX=0; CLAUDE=1; shift ;;
    --dry-run) DRY=1; shift ;;
    -h|--help) usage; exit 0 ;;
    *) echo "Unknown option: $1" >&2; exit 1 ;;
  esac
done

run(){ if [[ $DRY -eq 1 ]]; then printf 'DRY-RUN:'; printf ' %q' "$@"; printf '\n'; else "$@"; fi; }

SKILLS=(architecture deep-debug code-review security-review performance-review dependency-research project-bootstrap frontend-design design-system ui-audit responsive-design accessibility motion-design visual-refinement context-optimizer context-report)
AGENTS=(researcher.md architect.md debugger.md reviewer.md ui-designer.md visual-reviewer.md)

remove_claude_section(){
  local dst="$CLAUDE_HOME/CLAUDE.md" start="<!-- AI-PACK:GLOBAL:START -->" end="<!-- AI-PACK:GLOBAL:END -->"
  [[ -f "$dst" ]] || return 0
  if [[ $DRY -eq 1 ]]; then echo "DRY-RUN: remove managed AI Pack section from $dst"; return; fi
  local tmp; tmp="$(mktemp)"
  awk -v s="$start" -v e="$end" '$0==s {skip=1; next} $0==e {skip=0; next} !skip {print}' "$dst" > "$tmp"
  if grep -q '[^[:space:]]' "$tmp"; then mv "$tmp" "$dst"; else rm -f "$tmp" "$dst"; fi
}

if [[ $CURSOR -eq 1 ]]; then
  run rm -f "$HOME_DIR/.cursor/rules/engineering.mdc"
  for a in "${AGENTS[@]}"; do run rm -f "$HOME_DIR/.cursor/agents/$a"; done
  for s in "${SKILLS[@]}"; do run rm -rf "$HOME_DIR/.cursor/skills/$s"; done
fi
if [[ $CODEX -eq 1 ]]; then
  run rm -f "$HOME_DIR/.codex/rules/engineering.md"
  for a in "${AGENTS[@]}"; do run rm -f "$HOME_DIR/.codex/agents/$a"; done
  for s in "${SKILLS[@]}"; do run rm -rf "$HOME_DIR/.codex/skills/$s"; done
fi
if [[ $CLAUDE -eq 1 ]]; then
  remove_claude_section
  for a in "${AGENTS[@]}"; do run rm -f "$CLAUDE_HOME/agents/$a"; done
  for s in "${SKILLS[@]}"; do run rm -rf "$CLAUDE_HOME/skills/$s"; done
fi

echo "Known AI Global Pack v3.1 files removed."
