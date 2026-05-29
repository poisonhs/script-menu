# GitHub 在线脚本菜单

一个可以放在 GitHub 上在线运行的脚本菜单仓库，支持多个安装脚本集中管理，并通过中文彩色菜单选择执行。

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

安装 `bl` 短命令：

```sh
curl -fsSL https://raw.githubusercontent.com/poisonhs/script-menu/main/install-bl.sh | sh
```

安装完成后，后续直接运行：

```sh
bl
```

说明：

- `bootstrap.sh` 会先下载 `install.sh` 到临时文件，再执行，所以菜单可以正常交互输入。
- 主脚本启动后会先自动检查并补装基础依赖，再进入菜单。
