# k8s-jsonnet-manifest-packager

A docker image to package Kubernetes jsonnet manifests into a single YAML package

## Usage

- Run the docker image from `ghcr.io/srfrnk/k8s-jsonnet-manifest-packager:latest`
- Bind/mount your manifests folder into the container (Optionally as read-only if you don't have any imports to update)
- Add an argument for the input folder path (the path as mounted inside the container)
- Add any required `TLA` arguments with one or more `--tla-str '<KEY>=<VALUE>'` arguments
- To import external sources [follow this](#external-sources)
- The output `YAML` would be sent to `stdout` and can be collected/piped into a file

E.g.:

```bash
docker run --mount "type=bind,src=$PWD/manifests,dst=/src,readonly" ghcr.io/srfrnk/k8s-jsonnet-manifest-packager:latest -- /src --tla-str 'key=value>' > ./build/manifests.yaml
```

## External Sources

To import external sources add a file named `external-imports.yaml` to the input folder.
This file should contain key-values:

- key: relative path for the file
- value: URL to download the file from

E.g.:

```yaml
kube.libsonnet: https://raw.githubusercontent.com/srfrnk/jabos/main/manifests/kube.libsonnet
meta.libsonnet: https://raw.githubusercontent.com/srfrnk/jabos/main/manifests/kube.libsonnet
```
