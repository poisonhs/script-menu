#!/usr/bin/env bash

set -euo pipefail

echo "[apt-base] Updating packages and installing wget curl sudo vim git..."
apt update -y
apt install -y wget curl sudo vim git
