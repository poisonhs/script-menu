#!/usr/bin/env bash

set -euo pipefail

REPO_RAW_BASE="${REPO_RAW_BASE:-https://raw.githubusercontent.com/poisonhs/script-menu/main}"

if [[ -t 1 ]]; then
  C_RESET=$'\033[0m'
  C_TITLE=$'\033[1;36m'
  C_OK=$'\033[1;32m'
  C_WARN=$'\033[1;33m'
  C_ERR=$'\033[1;31m'
  C_NUM=$'\033[1;35m'
  C_DIM=$'\033[2m'
else
  C_RESET=""
  C_TITLE=""
  C_OK=""
  C_WARN=""
  C_ERR=""
  C_NUM=""
  C_DIM=""
fi

print_header() {
  printf "%s" "${C_TITLE}"
  cat <<'EOF'
========================================
         Script Menu 在线脚本菜单
========================================
EOF
  printf "%s\n" "${C_RESET}"
}

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
    printf "%s未识别到支持的包管理器，无法自动安装基础环境。%s\n" "${C_ERR}" "${C_RESET}"
    return 1
  fi

  printf "%s检测到包管理器：%s%s%s\n" "${C_OK}" "${C_NUM}" "${package_manager}" "${C_RESET}"

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

  printf "%s未检测到 curl/wget，开始自动安装基础环境。%s\n" "${C_WARN}" "${C_RESET}"
  install_base_environment
}

fetch_script() {
  local url="$1"

  ensure_fetch_tools

  if command -v curl >/dev/null 2>&1; then
    curl -fsSL "${url}"
  else
    wget -qO- "${url}"
  fi
}

run_downloaded_script() {
  local script_name="$1"
  local tmp_file

  tmp_file="/tmp/script-menu-${script_name}-$$.$(date +%s).sh"
  fetch_script "${REPO_RAW_BASE}/scripts/${script_name}.sh" > "${tmp_file}"
  chmod +x "${tmp_file}"

  bash "${tmp_file}"
  rm -f "${tmp_file}"
}

show_menu() {
  print_header
  printf "%s[1]%s Ubuntu/Debian 基础环境安装\n" "${C_NUM}" "${C_RESET}"
  printf "%s[2]%s Alpine 基础环境安装\n" "${C_NUM}" "${C_RESET}"
  printf "%s[3]%s Docker 安装\n" "${C_NUM}" "${C_RESET}"
  printf "%s[4]%s 节点搭建 Singbox Lite\n" "${C_NUM}" "${C_RESET}"
  printf "%s[5]%s IP 质量检测 IPv4\n" "${C_NUM}" "${C_RESET}"
  printf "%s[6]%s 添加 SWAP\n" "${C_NUM}" "${C_RESET}"
  printf "%s[7]%s SWAP 检测\n" "${C_NUM}" "${C_RESET}"
  printf "%s[8]%s 流媒体检测\n" "${C_NUM}" "${C_RESET}"
  printf "%s[9]%s BBR 检测\n" "${C_NUM}" "${C_RESET}"
  printf "%s[10]%s NodeQuality 质量检测\n" "${C_NUM}" "${C_RESET}"
  printf "%s[11]%s 退出\n" "${C_NUM}" "${C_RESET}"
  printf "\n%s提示：%s 也可以直接输入脚本名执行，例如：%sapt-base%s\n" "${C_WARN}" "${C_RESET}" "${C_OK}" "${C_RESET}"
}

run_remote_script() {
  local script_name="$1"
  printf "%s正在执行：%s%s%s\n" "${C_OK}" "${C_NUM}" "${script_name}" "${C_RESET}"
  run_downloaded_script "${script_name}"
}

run_choice() {
  case "${1:-}" in
    1|apt-base)
      run_remote_script "apt-base"
      ;;
    2|apk-base)
      run_remote_script "apk-base"
      ;;
    3|docker)
      run_remote_script "docker"
      ;;
    4|singbox-lite)
      run_remote_script "singbox-lite"
      ;;
    5|ip-check)
      run_remote_script "ip-check"
      ;;
    6|add-swap)
      run_remote_script "add-swap"
      ;;
    7|check-swap)
      run_remote_script "check-swap"
      ;;
    8|media-check)
      run_remote_script "media-check"
      ;;
    9|check-bbr)
      run_remote_script "check-bbr"
      ;;
    10|node-quality)
      run_remote_script "node-quality"
      ;;
    11|exit)
      printf "%s已退出。%s\n" "${C_WARN}" "${C_RESET}"
      ;;
    *)
      printf "%s无效选项：%s%s\n" "${C_ERR}" "$1" "${C_RESET}"
      exit 1
      ;;
  esac
}

prompt_choice() {
  printf "\n%s请输入编号或脚本名：%s" "${C_OK}" "${C_RESET}"
  read -r MENU_CHOICE

  case "${MENU_CHOICE:-}" in
    1|2|3|4|5|6|7|8|9|10|11|apt-base|apk-base|docker|singbox-lite|ip-check|add-swap|check-swap|media-check|check-bbr|node-quality|exit)
      return 0
      ;;
    *)
      printf "%s输入无效，请重新输入。%s\n" "${C_ERR}" "${C_RESET}"
      MENU_CHOICE=""
      return 1
      ;;
  esac
}

main() {
  ensure_fetch_tools

  if [[ $# -gt 0 ]]; then
    run_choice "$1"
    return
  fi

  while true; do
    show_menu
    if ! prompt_choice; then
      continue
    fi

    if [[ "${MENU_CHOICE}" == "11" || "${MENU_CHOICE}" == "exit" ]]; then
      run_choice "$MENU_CHOICE"
      return
    fi

    run_choice "$MENU_CHOICE"
    printf "\n%s按回车返回菜单...%s" "${C_WARN}" "${C_RESET}"
    read -r _
    printf "\n"
  done
}

main "$@"
