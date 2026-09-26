#!/usr/bin/env bash
# Rebuild helper: check -> dry-build -> switch.
# Usage: ./scripts/rebuild.sh <host> [--dry|--switch|--boot]
#   --dry    : validate only (default)
#   --switch : validate and activate now
#   --boot   : validate and activate on next reboot
set -euo pipefail

cd "$(dirname "$0")/.."

HOST="${1:?Usage: rebuild.sh <host> [--dry|--switch|--boot]}"
MODE="${2:---dry}"

echo "==> [1/3] nix flake check"
nix flake check

echo "==> [2/3] dry-build .#${HOST}"
sudo nixos-rebuild dry-build --flake ".#${HOST}"

case "$MODE" in
  --dry)
    echo "Dry run OK. Re-run with --switch to activate."
    ;;
  --switch|--boot)
    ACTION="${MODE#--}"
    echo "==> [3/3] nixos-rebuild ${ACTION} .#${HOST}"
    sudo nixos-rebuild "$ACTION" --flake ".#${HOST}"
    ;;
  *)
    echo "Unknown mode: $MODE (use --dry, --switch or --boot)" >&2
    exit 1
    ;;
esac
