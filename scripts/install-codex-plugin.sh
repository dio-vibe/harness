#!/usr/bin/env bash

set -euo pipefail

REPO_URL="${HARNESS_REPO_URL:-https://github.com/dio-vibe/harness.git}"
BRANCH="${HARNESS_BRANCH:-main}"
PLUGIN_NAME="harness"
INSTALL_ROOT="${HARNESS_INSTALL_ROOT:-$HOME/plugins}"
PLUGIN_DIR="${INSTALL_ROOT}/${PLUGIN_NAME}"
MARKETPLACE_PATH="${HARNESS_MARKETPLACE_PATH:-$HOME/.agents/plugins/marketplace.json}"

require_command() {
  if ! command -v "$1" >/dev/null 2>&1; then
    echo "Missing required command: $1" >&2
    exit 1
  fi
}

require_command git
require_command python3

mkdir -p "${INSTALL_ROOT}"

if [ -L "${PLUGIN_DIR}" ]; then
  TARGET_DIR="$(cd "$(dirname "${PLUGIN_DIR}")" && pwd)/$(readlink "${PLUGIN_DIR}")"
  if [ -d "${TARGET_DIR}/.git" ]; then
    echo "Updating symlink target at ${TARGET_DIR}"
    git -C "${TARGET_DIR}" fetch origin "${BRANCH}"
    git -C "${TARGET_DIR}" checkout "${BRANCH}"
    git -C "${TARGET_DIR}" pull --ff-only origin "${BRANCH}"
  else
    echo "Existing symlink ${PLUGIN_DIR} does not point to a git repository." >&2
    exit 1
  fi
elif [ -d "${PLUGIN_DIR}/.git" ]; then
  echo "Updating existing checkout at ${PLUGIN_DIR}"
  git -C "${PLUGIN_DIR}" fetch origin "${BRANCH}"
  git -C "${PLUGIN_DIR}" checkout "${BRANCH}"
  git -C "${PLUGIN_DIR}" pull --ff-only origin "${BRANCH}"
elif [ -e "${PLUGIN_DIR}" ]; then
  echo "Path already exists and is not a git checkout: ${PLUGIN_DIR}" >&2
  exit 1
else
  echo "Cloning ${REPO_URL} into ${PLUGIN_DIR}"
  git clone --branch "${BRANCH}" --depth 1 "${REPO_URL}" "${PLUGIN_DIR}"
fi

if [ ! -f "${PLUGIN_DIR}/.codex-plugin/plugin.json" ]; then
  echo "Expected Codex plugin manifest not found at ${PLUGIN_DIR}/.codex-plugin/plugin.json" >&2
  exit 1
fi

export MARKETPLACE_PATH
export PLUGIN_NAME

python3 <<'PY'
import json
import os
from pathlib import Path

marketplace_path = Path(os.environ["MARKETPLACE_PATH"]).expanduser()
plugin_name = os.environ["PLUGIN_NAME"]

if marketplace_path.exists():
    payload = json.loads(marketplace_path.read_text())
else:
    payload = {
        "name": "local-plugins",
        "interface": {"displayName": "Local Plugins"},
        "plugins": [],
    }

payload.setdefault("name", "local-plugins")
interface = payload.setdefault("interface", {})
interface.setdefault("displayName", "Local Plugins")
plugins = payload.setdefault("plugins", [])

entry = {
    "name": plugin_name,
    "source": {
        "source": "local",
        "path": f"./plugins/{plugin_name}",
    },
    "policy": {
        "installation": "AVAILABLE",
        "authentication": "ON_INSTALL",
    },
    "category": "Coding",
}

for index, existing in enumerate(plugins):
    if isinstance(existing, dict) and existing.get("name") == plugin_name:
        plugins[index] = entry
        break
else:
    plugins.append(entry)

marketplace_path.parent.mkdir(parents=True, exist_ok=True)
marketplace_path.write_text(json.dumps(payload, indent=2) + "\n")
PY

echo
echo "Harness for Codex is installed."
echo "Plugin path: ${PLUGIN_DIR}"
echo "Marketplace: ${MARKETPLACE_PATH}"
echo
echo "Restart Codex or open a new session, then try:"
echo "  Build a Codex harness for this project"
