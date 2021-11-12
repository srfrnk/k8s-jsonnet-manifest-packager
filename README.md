# k8s-jsonnet-manifest-packager

A docker image to package Kubernetes jsonnet manifests into a single YAML package

## Usage

- Run the docker image from `ghcr.io/srfrnk/k8s-jsonnet-manifest-packager:latest`
- Bind/mount your manifests folder into the container as `/src` path (Optionally as read-only)
- Add any required `TLA` arguments with one or more `--tla-str '<KEY>=<VALUE>'` arguments
- The output `YAML` would be sent to `stdout` and can be collected/piped into a file

E.g.:

```bash
docker run --mount "type=bind,src=$PWD/manifests,dst=/src,readonly" ghcr.io/srfrnk/k8s-jsonnet-manifest-packager:latest -- --tla-str 'key=value>' > ./build/manifests.yaml
```
