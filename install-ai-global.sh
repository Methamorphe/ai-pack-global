#!/usr/bin/env bash
set -euo pipefail

VERSION="3.0.0"
ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
T="$ROOT/templates/global"

CURSOR=1
CODEX=1
FORCE=0
DRY=0
NO_BACKUP=0
MODE="copy"

usage(){
cat <<'EOF'
AI Global Pack v3

Installs global rules, agents and skills into ~/.cursor and ~/.codex.
Never touches project-local configuration.

Usage:
  ./install-ai-global.sh
  ./install-ai-global.sh --dry-run
  ./install-ai-global.sh --cursor-only
  ./install-ai-global.sh --codex-only
  ./install-ai-global.sh --force
  ./install-ai-global.sh --symlink

Options:
  --cursor-only
  --codex-only
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
    --cursor-only) CURSOR=1; CODEX=0; shift ;;
    --codex-only) CURSOR=0; CODEX=1; shift ;;
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
STAMP="$(date +%Y%m%d-%H%M%S)"
BACKUP="$HOME_DIR/.ai-global-backups/$STAMP"

info(){ echo "==> $*"; }
warn(){ echo "WARN: $*" >&2; }

run(){
  if [[ $DRY -eq 1 ]]; then
    printf 'DRY-RUN:'
    printf ' %q' "$@"
    printf '\n'
  else
    "$@"
  fi
}

backup(){
  local src="$1"
  [[ -e "$src" || -L "$src" ]] || return 0
  [[ $NO_BACKUP -eq 0 ]] || return 0
  local rel="${src#$HOME_DIR/}"
  local dst="$BACKUP/$rel"
  run mkdir -p "$(dirname "$dst")"
  run cp -a "$src" "$dst"
}

install_file(){
  local src="$1" dst="$2"
  if [[ -e "$dst" || -L "$dst" ]]; then
    if [[ $FORCE -eq 0 ]]; then
      warn "Keeping existing: ${dst#$HOME_DIR/}"
      return
    fi
    backup "$dst"
    run rm -rf "$dst"
  fi
  run mkdir -p "$(dirname "$dst")"
  if [[ "$MODE" == "symlink" ]]; then
    run ln -s "$src" "$dst"
  else
    run cp "$src" "$dst"
  fi
  info "Installed ${dst#$HOME_DIR/}"
}

install_tree(){
  local src="$1" dst="$2"
  while IFS= read -r -d '' f; do
    rel="${f#$src/}"
    install_file "$f" "$dst/$rel"
  done < <(find "$src" -type f -print0)
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

echo
echo "AI Global Pack v3 complete."
echo "Mode: $MODE"
echo "No project-local files were modified."
