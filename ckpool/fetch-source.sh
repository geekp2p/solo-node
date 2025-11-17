#!/usr/bin/env bash
set -euo pipefail

REPO_URL="https://github.com/ckolivas/ckpool.git"
SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
SRC_DIR="${SCRIPT_DIR}/src"

printf 'Fetching ckpool sources from %s...\n' "$REPO_URL"
if [ -d "${SRC_DIR}/.git" ]; then
  git -C "$SRC_DIR" fetch --depth=1 origin master
  git -C "$SRC_DIR" reset --hard origin/master
else
  rm -rf "$SRC_DIR"
  git clone --depth=1 "$REPO_URL" "$SRC_DIR"
fi

# Preserve the placeholder file so the directory stays tracked while still ignored.
rm -f "${SRC_DIR}/.gitkeep"
touch "${SRC_DIR}/.gitkeep"

printf 'ckpool sources are now available in %s\n' "$SRC_DIR"