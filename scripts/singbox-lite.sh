#!/usr/bin/env bash

set -euo pipefail

if command -v curl >/dev/null 2>&1; then
  curl -LfsS https://raw.githubusercontent.com/0xdabiaoge/singbox-lite/main/singbox.sh -o /usr/local/bin/sb
elif command -v wget >/dev/null 2>&1; then
  wget -q https://raw.githubusercontent.com/0xdabiaoge/singbox-lite/main/singbox.sh -O /usr/local/bin/sb
else
  echo "curl 和 wget 都不可用，无法下载安装脚本。"
  exit 1
fi

chmod +x /usr/local/bin/sb
/usr/local/bin/sb
