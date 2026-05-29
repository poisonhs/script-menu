# GitHub Online Script Menu

一个可以放在 GitHub 上在线运行的脚本菜单仓库，支持多个安装脚本集中管理，并通过中文彩色菜单选择执行。

## Structure

```text
.
|-- install.sh
`-- scripts/
    |-- apt-base.sh
    |-- apk-base.sh
    |-- docker.sh
    `-- all-auto.sh
```

## How it works

- `install.sh` is the main entry point.
- Each script in `scripts/` has its own name.
- Users can run the main script from GitHub Raw and pick an option.

## 当前菜单

- `apt-base`: Ubuntu/Debian 基础环境安装
- `apk-base`: Alpine 基础环境安装
- `docker`: Docker 安装
- `all-auto`: 自动识别系统并安装基础环境 + Docker

## Before using

This template is already configured for:

- `poisonhs/script-menu`

## Usage

中文彩色菜单：

```bash
bash <(curl -fsSL https://raw.githubusercontent.com/poisonhs/script-menu/main/install.sh)
```

按脚本名直接执行：

```bash
curl -fsSL https://raw.githubusercontent.com/poisonhs/script-menu/main/install.sh | bash -s -- apt-base
curl -fsSL https://raw.githubusercontent.com/poisonhs/script-menu/main/install.sh | bash -s -- apk-base
curl -fsSL https://raw.githubusercontent.com/poisonhs/script-menu/main/install.sh | bash -s -- docker
curl -fsSL https://raw.githubusercontent.com/poisonhs/script-menu/main/install.sh | bash -s -- all-auto
```

## Suggested workflow

1. Create the GitHub repository `script-menu` under `poisonhs`.
2. Push these files.
3. Use the Raw URL to run the scripts online.
