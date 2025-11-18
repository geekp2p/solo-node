#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SRC_DIR="${SCRIPT_DIR}/src"
DEFAULT_URL="https://bitbucket.org/ckolivas/ckpool-solo.git"
REPO_URL="${CKPOOL_REPO_URL:-$DEFAULT_URL}"
REPO_BRANCH="${CKPOOL_REPO_BRANCH:-solobtc}"

if [ -f "${SRC_DIR}/autogen.sh" ]; then
  echo "[ckpool] Sources already present in ${SRC_DIR}. Remove them first to fetch again." >&2
  exit 0
fi

TMP_DIR="$(mktemp -d)"
cleanup() {
  rm -rf "${TMP_DIR}"
}
trap cleanup EXIT

echo "[ckpool] Cloning ${REPO_URL} (branch ${REPO_BRANCH})..."
git clone --depth 1 --branch "${REPO_BRANCH}" "${REPO_URL}" "${TMP_DIR}/ckpool"

rm -rf "${SRC_DIR}"
mkdir -p "${SRC_DIR}"
cp -a "${TMP_DIR}/ckpool/." "${SRC_DIR}/"
rm -rf "${SRC_DIR}/.git"

cat <<EONOTE
[ckpool] Sources copied into ${SRC_DIR}.
You can now run 'docker compose build ckpool-main --no-cache' or 'docker compose up --build'.
EONOTE