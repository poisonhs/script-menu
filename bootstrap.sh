#!/bin/sh

set -eu

REPO_RAW_BASE="${REPO_RAW_BASE:-https://raw.githubusercontent.com/poisonhs/script-menu/main}"
INSTALL_URL="${REPO_RAW_BASE}/install.sh"

detect_package_manager() {
  if command -v apt >/dev/null 2>&1; then
    echo "apt"
  elif command -v apk >/dev/null 2>&1; then
    echo "apk"
  elif command -v dnf >/dev/null 2>&1; then
    echo "dnf"
  elif command -v yum >/dev/null 2>&1; then
    echo "yum"
  else
    return 1
  fi
}

install_base_environment() {
  package_manager="$(detect_package_manager || true)"

  if [ -z "${package_manager}" ]; then
    echo "未识别到支持的包管理器，当前支持 apt / apk / dnf / yum。"
    exit 1
  fi

  echo "检测到包管理器: ${package_manager}"

  case "${package_manager}" in
    apt)
      apt update -y
      apt install -y bash curl wget sudo vim git
      ;;
    apk)
      apk update
      apk add bash curl wget sudo vim git
      ;;
    dnf)
      dnf install -y bash curl wget sudo vim git
      ;;
    yum)
      yum install -y bash curl wget sudo vim git
      ;;
  esac
}

ensure_fetch_tools() {
  if command -v curl >/dev/null 2>&1 || command -v wget >/dev/null 2>&1; then
    return 0
  fi

  echo "未检测到 curl/wget，开始自动安装基础环境..."
  install_base_environment
}

download_install_script() {
  target_file="$1"

  if command -v curl >/dev/null 2>&1; then
    curl -fsSL "${INSTALL_URL}" -o "${target_file}"
  else
    wget -q "${INSTALL_URL}" -O "${target_file}"
  fi
}

main() {
  ensure_fetch_tools

  tmp_file="/tmp/script-menu.$$.$(date +%s).sh"
  : > "${tmp_file}"
  trap 'rm -f "${tmp_file}"' EXIT INT TERM

  download_install_script "${tmp_file}"
  chmod +x "${tmp_file}"

  if [ -r /dev/tty ]; then
    bash "${tmp_file}" "$@" </dev/tty
  else
    bash "${tmp_file}" "$@"
  fi
}

main "$@"
