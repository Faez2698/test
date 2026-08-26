#!/bin/bash
set -euo pipefail

# Only relevant for Claude Code on the web / remote sessions, where the
# container (and any user-scope plugin installs) does not persist between
# sessions.
if [ "${CLAUDE_CODE_REMOTE:-}" != "true" ]; then
  exit 0
fi

MARKETPLACE="ui-ux-pro-max-skill"
PLUGIN="ui-ux-pro-max@${MARKETPLACE}"

if ! claude plugin list 2>/dev/null | grep -q "^  > ${PLUGIN}\$"; then
  claude plugin marketplace add "nextlevelbuilder/${MARKETPLACE}" >/dev/null 2>&1 || true
  claude plugin install "${PLUGIN}" >/dev/null 2>&1 || true
fi
