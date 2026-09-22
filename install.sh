#!/usr/bin/env bash
# Run by the VS Code Dev Containers extension after cloning this repo into a container.
set -euo pipefail

if ! command -v gh >/dev/null 2>&1; then
    echo "dotfiles: gh not on PATH; skipping credential helper setup." >&2
    exit 0
fi

# No absolute path, so the same config resolves on macOS and in Linux containers.
for host in github.com gist.github.com; do
    git config --global --unset-all "credential.https://$host.helper" || true
    git config --global --add "credential.https://$host.helper" ""
    git config --global --add "credential.https://$host.helper" '!gh auth git-credential'
done

echo "dotfiles: git will authenticate to GitHub through gh."

if [ -z "${GH_TOKEN:-}" ] && [ -z "${GITHUB_TOKEN:-}" ]; then
    echo "dotfiles: no GH_TOKEN in this container; add remoteEnv to devcontainer.json." >&2
fi
