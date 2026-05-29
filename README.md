# GitHub 在线脚本菜单

一个可以放在 GitHub 上在线运行的脚本菜单仓库，支持多个安装脚本集中管理，并通过中文彩色菜单选择执行。

## 目录结构

```text
.
|-- bootstrap.sh
|-- install.sh
`-- scripts/
    |-- apt-base.sh
    |-- apk-base.sh
    |-- add-swap.sh
    |-- bbr-optimize.sh
    |-- check-bbr.sh
    |-- check-swap.sh
    |-- docker.sh
    |-- ip-check.sh
    |-- media-check.sh
    |-- node-quality.sh
    |-- ping-check.sh
    `-- singbox-lite.sh
```

## 工作方式

- `install.sh` 是主入口脚本。
- `scripts/` 目录下的每个脚本都有独立名称。
- 用户可以通过 GitHub Raw 运行主脚本，然后在菜单中选择对应功能。

## 当前菜单

- `apt-base`: Ubuntu/Debian 基础环境安装
- `apk-base`: Alpine 基础环境安装
- `docker`: Docker 安装
- `singbox-lite`: 节点搭建 Singbox Lite
- `ip-check`: IP 质量检测 IPv4
- `add-swap`: 添加 SWAP
- `check-swap`: SWAP 检测
- `media-check`: 流媒体检测
- `check-bbr`: BBR 检测
- `ping-check`: Ping 检测
- `bbr-optimize`: BBR 优化
- `node-quality`: NodeQuality 质量检测

## 使用前说明

当前模板已经配置为：

- `poisonhs/script-menu`

## 使用方法

推荐启动

Ubuntu / Debian：

```sh
apt update -y && apt install -y curl bash && curl -fsSL https://raw.githubusercontent.com/poisonhs/script-menu/main/bootstrap.sh | sh
```

Alpine：

```sh
apk update && apk add bash curl && curl -fsSL https://raw.githubusercontent.com/poisonhs/script-menu/main/bootstrap.sh | sh
```

如果机器已经有 `curl`：

```bash
curl -fsSL https://raw.githubusercontent.com/poisonhs/script-menu/main/bootstrap.sh | sh
```

如果机器已经有 `wget`：

```sh
wget -qO- https://raw.githubusercontent.com/poisonhs/script-menu/main/bootstrap.sh | sh
```

说明：

- `bootstrap.sh` 会先下载 `install.sh` 到临时文件，再执行，所以菜单可以正常交互输入。
- 主脚本启动后会先自动检查并补装基础依赖，再进入菜单。

按脚本名直接执行：

```bash
curl -fsSL https://raw.githubusercontent.com/poisonhs/script-menu/main/install.sh | bash -s -- apt-base
curl -fsSL https://raw.githubusercontent.com/poisonhs/script-menu/main/install.sh | bash -s -- apk-base
curl -fsSL https://raw.githubusercontent.com/poisonhs/script-menu/main/install.sh | bash -s -- docker
curl -fsSL https://raw.githubusercontent.com/poisonhs/script-menu/main/install.sh | bash -s -- singbox-lite
curl -fsSL https://raw.githubusercontent.com/poisonhs/script-menu/main/install.sh | bash -s -- ip-check
curl -fsSL https://raw.githubusercontent.com/poisonhs/script-menu/main/install.sh | bash -s -- add-swap
curl -fsSL https://raw.githubusercontent.com/poisonhs/script-menu/main/install.sh | bash -s -- check-swap
curl -fsSL https://raw.githubusercontent.com/poisonhs/script-menu/main/install.sh | bash -s -- media-check
curl -fsSL https://raw.githubusercontent.com/poisonhs/script-menu/main/install.sh | bash -s -- check-bbr
curl -fsSL https://raw.githubusercontent.com/poisonhs/script-menu/main/install.sh | bash -s -- ping-check
curl -fsSL https://raw.githubusercontent.com/poisonhs/script-menu/main/install.sh | bash -s -- bbr-optimize
curl -fsSL https://raw.githubusercontent.com/poisonhs/script-menu/main/install.sh | bash -s -- node-quality
```

## 建议流程

1. 在 `poisonhs` 账号下创建 `script-menu` 仓库。
2. 推送这些文件。
3. 使用 Raw 链接在线运行脚本。
