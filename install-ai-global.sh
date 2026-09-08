#!/usr/bin/env bash
set -euo pipefail

VERSION="3.1.0"
ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
T="$ROOT/templates/global"

CURSOR=1
CODEX=1
CLAUDE=1
FORCE=0
DRY=0
NO_BACKUP=0
MODE="copy"

usage(){
cat <<'EOF'
AI Global Pack v3.1 — Cursor + Codex + Claude Code

Installs global rules, agents and skills into:
  ~/.cursor
  ~/.codex
  ${CLAUDE_CONFIG_DIR:-~/.claude}

Never touches project-local configuration.

Usage:
  ./install-ai-global.sh
  ./install-ai-global.sh --dry-run
  ./install-ai-global.sh --cursor-only
  ./install-ai-global.sh --codex-only
  ./install-ai-global.sh --claude-only
  ./install-ai-global.sh --force
  ./install-ai-global.sh --symlink

Options:
  --cursor-only
  --codex-only
  --claude-only
  --force
  --dry-run
  --no-backup
  --symlink
  --copy
  -h, --help
  --version
EOF
}

while [[ $# -gt 0 ]]; do
  case "$1" in
    --cursor-only) CURSOR=1; CODEX=0; CLAUDE=0; shift ;;
    --codex-only) CURSOR=0; CODEX=1; CLAUDE=0; shift ;;
    --claude-only) CURSOR=0; CODEX=0; CLAUDE=1; shift ;;
    --force) FORCE=1; shift ;;
    --dry-run) DRY=1; shift ;;
    --no-backup) NO_BACKUP=1; shift ;;
    --symlink) MODE="symlink"; shift ;;
    --copy) MODE="copy"; shift ;;
    -h|--help) usage; exit 0 ;;
    --version) echo "$VERSION"; exit 0 ;;
    *) echo "Unknown option: $1" >&2; exit 1 ;;
  esac
done

HOME_DIR="${HOME:?HOME not set}"
CLAUDE_HOME="${CLAUDE_CONFIG_DIR:-$HOME_DIR/.claude}"
STAMP="$(date +%Y%m%d-%H%M%S)"
BACKUP="$HOME_DIR/.ai-global-backups/$STAMP"

info(){ echo "==> $*"; }
warn(){ echo "WARN: $*" >&2; }
run(){ if [[ $DRY -eq 1 ]]; then printf 'DRY-RUN:'; printf ' %q' "$@"; printf '\n'; else "$@"; fi; }

backup(){
  local src="$1"; [[ -e "$src" || -L "$src" ]] || return 0; [[ $NO_BACKUP -eq 0 ]] || return 0
  local rel
  if [[ "$src" == "$HOME_DIR/"* ]]; then rel="${src#$HOME_DIR/}"; else rel="external/$(printf '%s' "$src" | sed 's#^/##; s#/#__#g')"; fi
  local dst="$BACKUP/$rel"; run mkdir -p "$(dirname "$dst")"; run cp -a "$src" "$dst"
}

install_file(){
  local src="$1" dst="$2"
  if [[ -e "$dst" || -L "$dst" ]]; then
    if [[ $FORCE -eq 0 ]]; then warn "Keeping existing: $dst"; return; fi
    backup "$dst"; run rm -rf "$dst"
  fi
  run mkdir -p "$(dirname "$dst")"
  if [[ "$MODE" == "symlink" ]]; then run ln -s "$src" "$dst"; else run cp "$src" "$dst"; fi
  info "Installed $dst"
}

install_tree(){
  local src="$1" dst="$2"
  while IFS= read -r -d '' f; do local rel="${f#$src/}"; install_file "$f" "$dst/$rel"; done < <(find "$src" -type f -print0)
}

merge_claude_md(){
  local src="$T/claude/CLAUDE.md" dst="$CLAUDE_HOME/CLAUDE.md" start="<!-- AI-PACK:GLOBAL:START -->" end="<!-- AI-PACK:GLOBAL:END -->"
  if [[ $DRY -eq 1 ]]; then info "Would merge managed global instructions into $dst"; return; fi
  mkdir -p "$(dirname "$dst")"; [[ -e "$dst" ]] && backup "$dst"
  local tmp old; tmp="$(mktemp)"; old="$(mktemp)"
  if [[ -f "$dst" ]]; then awk -v s="$start" -v e="$end" '$0==s {skip=1; next} $0==e {skip=0; next} !skip {print}' "$dst" > "$old"; else : > "$old"; fi
  { cat "$old"; [[ -s "$old" ]] && printf '\n'; printf '%s\n' "$start"; cat "$src"; printf '%s\n' "$end"; } > "$tmp"
  mv "$tmp" "$dst"; rm -f "$old"; info "Updated $dst"
}

if [[ $CURSOR -eq 1 ]]; then
  info "Installing Cursor global config"
  install_tree "$T/cursor/rules" "$HOME_DIR/.cursor/rules"
  install_tree "$T/cursor/agents" "$HOME_DIR/.cursor/agents"
  install_tree "$T/skills" "$HOME_DIR/.cursor/skills"
fi

if [[ $CODEX -eq 1 ]]; then
  info "Installing Codex global config"
  install_tree "$T/codex/rules" "$HOME_DIR/.codex/rules"
  install_tree "$T/codex/agents" "$HOME_DIR/.codex/agents"
  install_tree "$T/skills" "$HOME_DIR/.codex/skills"
fi

if [[ $CLAUDE -eq 1 ]]; then
  info "Installing Claude Code global config"
  merge_claude_md
  install_tree "$T/claude/agents" "$CLAUDE_HOME/agents"
  install_tree "$T/skills" "$CLAUDE_HOME/skills"
fi

echo
echo "AI Global Pack v3.1 complete."
echo "Mode: $MODE"
echo "Targets: Cursor=$CURSOR Codex=$CODEX Claude=$CLAUDE"
echo "No project-local files were modified."
