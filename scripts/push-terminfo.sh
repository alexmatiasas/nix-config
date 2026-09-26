#!/usr/bin/env bash
# Push the Ghostty terminfo entry to a remote host so that
# TERM=xterm-ghostty is recognized over SSH (colors, keys, etc.).
# Run once per host, re-run after recreating it.
# Usage: ./scripts/push-terminfo.sh [[user@]host]
# Example: ./scripts/push-terminfo.sh alexmatias@192.168.64.11
set -euo pipefail

REMOTE="${1:?Usage: push-terminfo.sh [[user@]host]}"

infocmp -x xterm-ghostty | ssh "$REMOTE" 'tic -x -'

echo "Ghostty terminfo installed on ${REMOTE}."
