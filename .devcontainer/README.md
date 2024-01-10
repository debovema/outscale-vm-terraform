# Devcontainer configuration

## Podman support

Edit your `containers.conf` file to add Podman support for [Devcontainers](https://code.visualstudio.com/docs/devcontainers/containers).

```shell
cat <<EOF > $HOME/.config/containers/containers.conf
[containers]
  env = ["BUILDAH_FORMAT=docker"]
  label=false
  userns = "keep-id"
EOF
```