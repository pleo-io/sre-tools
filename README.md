# Network Tools

Public docker image with dig/curlie/nc/etc. installed. Useful to drop into a Kubernetes cluster to investigate network issues.

```
kubectl run -it nt --image network-tools:latest bash
```

```
kubectl debug -it --image=ghcr.io/pleo-io/network-tools:latest $PODNAME
```

```
docker run --rm \
  -it \
  network-tools:latest \
    bash
```

## Contents

- [vault](https://developer.hashicorp.com/vault/docs/commands)
- curl
- [curlie](https://github.com/rs/curlie)
- dnsutils
- [jq](https://github.com/jqlang/jq)
- [kafka-tools](https://docs.confluent.io/kafka/operations-tools/kafka-tools.html)
- [mycli](https://www.mycli.net/)
- [netcat](https://en.wikipedia.org/wiki/Netcat)
- [pgcli](https://www.pgcli.com/)
- [websocat](https://github.com/vi/websocat)
