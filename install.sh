#!/usr/bin/env bash
# Run by the VS Code Dev Containers extension after cloning this repo into a container.
set -euo pipefail

# Deliberately no `git config --global` here. The Dev Containers extension copies the
# host ~/.gitconfig into the container only when that file does not already exist, so
# creating it from this script silently drops user.name/user.email and the host's
# credential helper configuration.
if [ -f "$HOME/.gitconfig" ]; then
    echo "dotfiles: ~/.gitconfig already exists; the host git config will NOT be copied." >&2
fi

if ! command -v gh >/dev/null 2>&1; then
    echo "dotfiles: gh not on PATH; git will use the VS Code credential proxy."
    exit 0
fi

if [ -n "${GH_TOKEN:-}" ] || [ -n "${GITHUB_TOKEN:-}" ]; then
    echo "dotfiles: gh will use GH_TOKEN/GITHUB_TOKEN from the container environment."
elif gh auth status --hostname github.com >/dev/null 2>&1; then
    echo "dotfiles: gh is already authenticated for github.com."
else
    echo "dotfiles: gh is not authenticated yet."
    echo "dotfiles: VS Code signs it in at connect time when 'dev.containers.githubCLILoginWithToken' is true."
    echo "dotfiles: if git auth still fails, run 'gh auth login --hostname github.com' here."
fi
