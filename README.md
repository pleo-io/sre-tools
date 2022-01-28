# Network Tools

Public docker image with dig/curlie/nc/etc. installed. Usefult to drop into a kubernetes cluster to investigate network issues.

```
kubectl run -it nt --image network-tools:latest bash
```

```
docker run --rm \
  -it \
  network-tools:latest \
    bash
```
