#!/usr/bin/env bash
set -euo pipefail
for s in skills/*/; do
  n=$(basename "$s"); d="$HOME/.claude/skills/$n"
  if [ -e "$d" ]; then echo "skip $n (exists)"; else mkdir -p "$HOME/.claude/skills" && cp -R "$s" "$d" && echo "installed $n"; fi
done
[ -e "$HOME/.claude/skills/new-idea/LEARNINGS.md" ] || cp templates/LEARNINGS.md "$HOME/.claude/skills/new-idea/LEARNINGS.md" 2>/dev/null || true
