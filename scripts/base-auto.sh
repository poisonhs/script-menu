#!/usr/bin/env bash

set -euo pipefail

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
  local package_manager

  if ! package_manager="$(detect_package_manager)"; then
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

install_base_environment
