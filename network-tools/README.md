# Network Tools

Public docker image with dig/curlie/nc/etc. installed. Useful to drop into a Kubernetes cluster to investigate network issues.

## Usage

### Docker

```
docker run --rm -it network-tools:latest bash
```

### Kubernetes

:warning: Note: you have to set the _namespace_ and _security level_ correctly.

Simply launching a temporary debug container:

```bash
kubectl run "debug-${USER//./-}" --image=ghcr.io/pleo-io/network-tools:latest --rm -it /
-n $NAMESPACE -lpleo.io/security-level=$SECURITY_LEVEL
```

To make it run "longer":

```bash
kubectl run "debug-${USER//./-}" --image=ghcr.io/pleo-io/network-tools:latest --rm -it /
-n $NAMESPACE -lpleo.io/security-level=$SECURITY_LEVEL -- sleep infinity
```

To launch a proper ephemeral debug container targetting the `app` container:

```bash
kubectl debug -it --image=ghcr.io/pleo-io/network-tools:latest /
--target app -n $NAMESPACE $PODNAME
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