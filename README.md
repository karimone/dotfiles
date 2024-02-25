# My dotfiles

The dotfiles are managed using [chezmoi](https://chezmoi.io)

## Requirements

The secrets are managed using the `bitwarden-cli` tool that must be installed using the following [instructions](https://bitwarden.com/help/cli/#download-and-install)


Is it possible also to install bw using node.

First install nvm:

```shell
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash
```

Then install node and bitwarden-cli

```shell
nvm install stable
nvm use stable
npm install -g @bitwarden/cli
export NODE_OPTIONS="--no-deprecation"
```

## Install

The `install.sh` script take cares of everything. Just run:

```shell
curl -sSL https://bit.ly/kngfiles
```

