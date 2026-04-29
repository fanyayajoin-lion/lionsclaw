#!/bin/bash
set -e
WORKSPACE_DIR="${OPENCLAW_WORKSPACE:-/home/node/.openclaw/workspace}"
LOG_FILE="$WORKSPACE_DIR/memory/backup.log"
cd "$WORKSPACE_DIR"
if ! git diff --quiet || ! git diff --cached --quiet || [ -n "$(git ls-files --others --exclude-standard)" ]; then
  git add -A
  git commit -m "auto-backup: $(TZ=Asia/Taipei date '+%Y-%m-%d %H:%M') TW"
  git push origin main
  echo "$(TZ=Asia/Taipei date '+%Y-%m-%d %H:%M') [OK] pushed to GitHub" >> "$LOG_FILE"
else
  echo "$(TZ=Asia/Taipei date '+%Y-%m-%d %H:%M') [SKIP] nothing to commit" >> "$LOG_FILE"
fi
