# GitHub Online Script Menu

一个可以放在 GitHub 上在线运行的脚本菜单仓库，支持多个安装脚本集中管理，并通过中文彩色菜单选择执行。

## Structure

```text
.
|-- bootstrap.sh
|-- install.sh
`-- scripts/
    |-- apt-base.sh
    |-- apk-base.sh
    |-- add-swap.sh
    |-- base-auto.sh
    |-- check-bbr.sh
    |-- check-swap.sh
    |-- docker.sh
    |-- ip-check.sh
    |-- media-check.sh
    |-- node-quality.sh
    |-- singbox-lite.sh
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
- `base-auto`: 自动识别系统并安装基础环境
- `singbox-lite`: 节点搭建 Singbox Lite
- `ip-check`: IP 质量检测 IPv4
- `add-swap`: 添加 SWAP
- `check-swap`: SWAP 检测
- `media-check`: 流媒体检测
- `check-bbr`: BBR 检测
- `node-quality`: NodeQuality 质量检测

## Before using

This template is already configured for:

- `poisonhs/script-menu`

## Usage

中文彩色菜单：

```bash
bash <(curl -fsSL https://raw.githubusercontent.com/poisonhs/script-menu/main/install.sh)
```

无 `curl` / `wget` 的新机器，推荐先用这个自动识别启动命令：

```sh
sh -c 'URL="https://raw.githubusercontent.com/poisonhs/script-menu/main/bootstrap.sh"; if command -v curl >/dev/null 2>&1; then curl -fsSL "$URL" | sh; elif command -v wget >/dev/null 2>&1; then wget -qO- "$URL" | sh; elif command -v apt >/dev/null 2>&1; then apt update -y && apt install -y bash curl wget sudo vim git && curl -fsSL "$URL" | sh; elif command -v apk >/dev/null 2>&1; then apk update && apk add bash curl wget sudo vim git && curl -fsSL "$URL" | sh; elif command -v dnf >/dev/null 2>&1; then dnf install -y bash curl wget sudo vim git && curl -fsSL "$URL" | sh; elif command -v yum >/dev/null 2>&1; then yum install -y bash curl wget sudo vim git && curl -fsSL "$URL" | sh; else echo "不支持的系统：缺少 curl/wget，且未找到 apt/apk/dnf/yum"; exit 1; fi'
```

上面这个启动方式会先下载到临时文件，再执行，所以菜单可以正常交互输入。

按脚本名直接执行：

```bash
curl -fsSL https://raw.githubusercontent.com/poisonhs/script-menu/main/install.sh | bash -s -- apt-base
curl -fsSL https://raw.githubusercontent.com/poisonhs/script-menu/main/install.sh | bash -s -- apk-base
curl -fsSL https://raw.githubusercontent.com/poisonhs/script-menu/main/install.sh | bash -s -- docker
curl -fsSL https://raw.githubusercontent.com/poisonhs/script-menu/main/install.sh | bash -s -- all-auto
curl -fsSL https://raw.githubusercontent.com/poisonhs/script-menu/main/install.sh | bash -s -- base-auto
curl -fsSL https://raw.githubusercontent.com/poisonhs/script-menu/main/install.sh | bash -s -- singbox-lite
curl -fsSL https://raw.githubusercontent.com/poisonhs/script-menu/main/install.sh | bash -s -- ip-check
curl -fsSL https://raw.githubusercontent.com/poisonhs/script-menu/main/install.sh | bash -s -- add-swap
curl -fsSL https://raw.githubusercontent.com/poisonhs/script-menu/main/install.sh | bash -s -- check-swap
curl -fsSL https://raw.githubusercontent.com/poisonhs/script-menu/main/install.sh | bash -s -- media-check
curl -fsSL https://raw.githubusercontent.com/poisonhs/script-menu/main/install.sh | bash -s -- check-bbr
curl -fsSL https://raw.githubusercontent.com/poisonhs/script-menu/main/install.sh | bash -s -- node-quality
```

## Suggested workflow

1. Create the GitHub repository `script-menu` under `poisonhs`.
2. Push these files.
3. Use the Raw URL to run the scripts online.
