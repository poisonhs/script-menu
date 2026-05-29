#!/bin/sh

set -eu

LAUNCHER_URL="https://raw.githubusercontent.com/poisonhs/script-menu/main/bootstrap.sh"
TARGET_PATH="${TARGET_PATH:-/usr/local/bin/bl}"

write_launcher() {
  target_file="$1"

  cat > "${target_file}" <<EOF
#!/bin/sh
set -eu
URL="${LAUNCHER_URL}"

if command -v curl >/dev/null 2>&1; then
  exec sh -c 'curl -fsSL "\$1" | sh' sh "\$URL"
elif command -v wget >/dev/null 2>&1; then
  exec sh -c 'wget -qO- "\$1" | sh' sh "\$URL"
else
  echo "未检测到 curl 或 wget，请先安装后再运行 bl。"
  exit 1
fi
EOF

  chmod +x "${target_file}"
}

install_launcher() {
  if [ -w "$(dirname "${TARGET_PATH}")" ]; then
    write_launcher "${TARGET_PATH}"
    echo "安装完成：${TARGET_PATH}"
    return 0
  fi

  if command -v sudo >/dev/null 2>&1; then
    temp_file="/tmp/bl.$$.$(date +%s)"
    write_launcher "${temp_file}"
    sudo mv "${temp_file}" "${TARGET_PATH}"
    sudo chmod +x "${TARGET_PATH}"
    echo "安装完成：${TARGET_PATH}"
    return 0
  fi

  echo "没有权限写入 ${TARGET_PATH}，也未检测到 sudo。"
  exit 1
}

install_launcher
