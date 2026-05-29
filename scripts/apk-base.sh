#!/usr/bin/env bash

set -euo pipefail

echo "[apk-base] Updating packages and installing sudo curl wget bash..."
apk update
apk add sudo curl wget bash
