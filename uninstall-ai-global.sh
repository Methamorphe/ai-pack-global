#!/usr/bin/env bash
set -euo pipefail
HOME_DIR="${HOME:?HOME not set}"
CURSOR=1
CODEX=1
DRY=0

while [[ $# -gt 0 ]]; do
  case "$1" in
    --cursor-only) CURSOR=1; CODEX=0; shift ;;
    --codex-only) CURSOR=0; CODEX=1; shift ;;
    --dry-run) DRY=1; shift ;;
    -h|--help) echo "Usage: ./uninstall-ai-global.sh [--cursor-only|--codex-only|--dry-run]"; exit 0 ;;
    *) echo "Unknown option: $1" >&2; exit 1 ;;
  esac
done

run(){
  if [[ $DRY -eq 1 ]]; then
    printf 'DRY-RUN:'
    printf ' %q' "$@"
    printf '\n'
  else
    "$@"
  fi
}

SKILLS=(architecture deep-debug code-review security-review performance-review dependency-research project-bootstrap frontend-design design-system ui-audit responsive-design accessibility motion-design visual-refinement context-optimizer context-report)
AGENTS=(researcher.md architect.md debugger.md reviewer.md ui-designer.md visual-reviewer.md)

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

echo "Known AI Global Pack v3 files removed."
