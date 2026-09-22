# dotfiles

Applied automatically to every VS Code dev container via `dotfiles.repository`.

`install.sh` points git at `gh` as its credential helper using a PATH-relative
command, so the same config works on macOS and inside Linux containers.

## Getting a token into a container

`gh` stores tokens in the macOS keyring, which containers cannot read. The `gha`
shell function publishes the active account's token to the launchd session as
`GH_CONTAINER_TOKEN`. Each repo's `.devcontainer/devcontainer.json` forwards it:

```json
"remoteEnv": {
    "GH_TOKEN": "${localEnv:GH_CONTAINER_TOKEN}"
}
```

VS Code must be restarted after the first `gha` run to pick up the variable.
Run `gha clear` to stop publishing it.
