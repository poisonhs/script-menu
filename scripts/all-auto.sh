#!/usr/bin/env bash

set -euo pipefail

if command -v apt >/dev/null 2>&1; then
  curl -fsSL "https://raw.githubusercontent.com/poisonhs/script-menu/main/scripts/apt-base.sh" | bash
elif command -v apk >/dev/null 2>&1; then
  curl -fsSL "https://raw.githubusercontent.com/poisonhs/script-menu/main/scripts/apk-base.sh" | bash
else
  echo "Unsupported package manager. This script supports apt and apk."
  exit 1
fi

curl -fsSL "https://raw.githubusercontent.com/poisonhs/script-menu/main/scripts/docker.sh" | bash
