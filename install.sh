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

show_menu() {
  print_header
  printf "%s[1]%s Ubuntu/Debian 基础环境安装 %s(apt-base)%s\n" "${C_NUM}" "${C_RESET}" "${C_DIM}" "${C_RESET}"
  printf "%s[2]%s Alpine 基础环境安装 %s(apk-base)%s\n" "${C_NUM}" "${C_RESET}" "${C_DIM}" "${C_RESET}"
  printf "%s[3]%s Docker 安装 %s(docker)%s\n" "${C_NUM}" "${C_RESET}" "${C_DIM}" "${C_RESET}"
  printf "%s[4]%s 自动识别系统并安装基础环境 + Docker %s(all-auto)%s\n" "${C_NUM}" "${C_RESET}" "${C_DIM}" "${C_RESET}"
  printf "%s[5]%s 节点搭建 Singbox Lite %s(singbox-lite)%s\n" "${C_NUM}" "${C_RESET}" "${C_DIM}" "${C_RESET}"
  printf "%s[6]%s IP 质量检测 IPv4 %s(ip-check)%s\n" "${C_NUM}" "${C_RESET}" "${C_DIM}" "${C_RESET}"
  printf "%s[7]%s 添加 SWAP %s(add-swap)%s\n" "${C_NUM}" "${C_RESET}" "${C_DIM}" "${C_RESET}"
  printf "%s[8]%s SWAP 检测 %s(check-swap)%s\n" "${C_NUM}" "${C_RESET}" "${C_DIM}" "${C_RESET}"
  printf "%s[9]%s 流媒体检测 %s(media-check)%s\n" "${C_NUM}" "${C_RESET}" "${C_DIM}" "${C_RESET}"
  printf "%s[10]%s BBR 检测 %s(check-bbr)%s\n" "${C_NUM}" "${C_RESET}" "${C_DIM}" "${C_RESET}"
  printf "%s[11]%s NodeQuality 质量检测 %s(node-quality)%s\n" "${C_NUM}" "${C_RESET}" "${C_DIM}" "${C_RESET}"
  printf "%s[12]%s 退出\n" "${C_NUM}" "${C_RESET}"
  printf "\n%s提示：%s 也可以直接传脚本名执行，例如：%sbash install.sh apt-base%s\n" "${C_WARN}" "${C_RESET}" "${C_OK}" "${C_RESET}"
}

run_remote_script() {
  local script_name="$1"
  printf "%s正在执行：%s%s%s\n" "${C_OK}" "${C_NUM}" "${script_name}" "${C_RESET}"
  curl -fsSL "${REPO_RAW_BASE}/scripts/${script_name}.sh" | bash
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
    4|all-auto)
      run_remote_script "all-auto"
      ;;
    5|singbox-lite)
      run_remote_script "singbox-lite"
      ;;
    6|ip-check)
      run_remote_script "ip-check"
      ;;
    7|add-swap)
      run_remote_script "add-swap"
      ;;
    8|check-swap)
      run_remote_script "check-swap"
      ;;
    9|media-check)
      run_remote_script "media-check"
      ;;
    10|check-bbr)
      run_remote_script "check-bbr"
      ;;
    11|node-quality)
      run_remote_script "node-quality"
      ;;
    12|exit)
      printf "%s已退出。%s\n" "${C_WARN}" "${C_RESET}"
      ;;
    *)
      printf "%s无效选项：%s%s\n" "${C_ERR}" "$1" "${C_RESET}"
      exit 1
      ;;
  esac
}

prompt_choice() {
  local choice
  while true; do
    printf "\n%s请输入编号或脚本名：%s" "${C_OK}" "${C_RESET}"
    read -r choice

    case "${choice:-}" in
      1|2|3|4|5|6|7|8|9|10|11|12|apt-base|apk-base|docker|all-auto|singbox-lite|ip-check|add-swap|check-swap|media-check|check-bbr|node-quality|exit)
        run_choice "$choice"
        return
        ;;
      *)
        printf "%s输入无效，请重新输入。%s\n" "${C_ERR}" "${C_RESET}"
        ;;
    esac
  done
}

main() {
  if [[ $# -gt 0 ]]; then
    run_choice "$1"
    return
  fi

  show_menu
  prompt_choice
}

main "$@"
