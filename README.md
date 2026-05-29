# GitHub Online Script Menu

This repository structure lets you keep multiple install scripts on GitHub and run them online.

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

## Before using

This template is already configured for:

- `poisonhs/script-menu`

## Usage

Interactive menu:

```bash
bash <(curl -fsSL https://raw.githubusercontent.com/poisonhs/script-menu/main/install.sh)
```

Run a named script directly:

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
