#!/usr/bin/env bash

set -euo pipefail

REPO_RAW_BASE="${REPO_RAW_BASE:-https://raw.githubusercontent.com/poisonhs/script-menu/main}"

show_menu() {
  cat <<'EOF'
Choose a script to run:
1) apt-base
2) apk-base
3) docker
4) all-auto
5) exit
EOF
}

run_remote_script() {
  local script_name="$1"
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
    5|exit)
      echo "Bye."
      ;;
    *)
      echo "Unknown option: $1"
      exit 1
      ;;
  esac
}

main() {
  if [[ $# -gt 0 ]]; then
    run_choice "$1"
    return
  fi

  show_menu
  read -r -p "Enter your choice: " choice
  run_choice "$choice"
}

main "$@"
