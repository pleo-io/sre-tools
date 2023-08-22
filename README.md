> :warning: This repository was archived automatically since no ownership was defined :warning:
>
> For details on how to claim stewardship of this repository see:
>
> [How to configure a service in OpsLevel](https://www.notion.so/pleo/How-to-configure-a-service-in-OpsLevel-f6483fcb4fdd4dcc9fc32b7dfe14c262)
>
> To learn more about the automatic process for stewardship which archived this repository see:
>
> [Automatic process for stewardship](https://www.notion.so/pleo/Automatic-process-for-stewardship-43d9def9bc9a4010aba27144ef31e0f2)

> :warning: This repository was archived automatically since no ownership was defined :warning:
>
> For details on how to claim stewardship of this repository see:
>
> [How to configure a service in OpsLevel](https://www.notion.so/pleo/How-to-configure-a-service-in-OpsLevel-f6483fcb4fdd4dcc9fc32b7dfe14c262)
>
> To learn more about the automatic process for stewardship which archived this repository see:
>
> [Automatic process for stewardship](https://www.notion.so/pleo/Automatic-process-for-stewardship-43d9def9bc9a4010aba27144ef31e0f2)

# Network Tools

Public docker image with dig/curlie/nc/etc. installed. Usefult to drop into a kubernetes cluster to investigate network issues.

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
