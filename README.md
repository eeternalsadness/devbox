# Devbox

This repo aims to consolidate my local development environment's configuration using [devbox](https://www.jetify.com/docs/devbox/).

## Philosophy

I aim for a minimalistic lifestyle where I can carry anything with me anywhere I want with minimal effort. As an extension of that, I want to have a portable workspace that I can set up on any machine with at most a few commands.

I've tried to use `Docker` for this use case, but one of the biggest problems that I face when using dev containers is when I need to interact with the host's filesystem. My hope is that `devbox` would solve this problem and provide me with a seamless experience.

## Current Configuration

My current configuration consists of dotfiles, scripts, and a `Docker` workspace, which can be found in the following repos:

- Dotfiles: [https://github.com/eeternalsadness/dotfiles](https://github.com/eeternalsadness/dotfiles)
- Scripts: [https://github.com/eeternalsadness/scripts](https://github.com/eeternalsadness/scripts)
- Docker workspace: [https://github.com/eeternalsadness/docker-workspace](https://github.com/eeternalsadness/docker-workspace)

## Getting Started

### Prerequisite

Please make sure that the following packages are installed:

- curl
- git
- xz-utils

### Installation

To install the `devbox` setup with dotfiles and scripts, run the following command:

```shell
/bin/bash <(curl -fsSL https://raw.githubusercontent.com/eeternalsadness/scripts/refs/heads/master/devbox/init.sh)
```

### Usage

After installation is complete, just run `dbs` to start your shell environment :D.
