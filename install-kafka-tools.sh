#!/bin/bash

set -e
set -u

INSTALL_DIR=${1:-/opt/kafka}
KAFKA_SHA256="18ad8a365fb111de249d3bb8bf3c96cd1af060ec8fb3e3d1fc4a7ae10d9042de"
KAFKA_URL="https://archive.apache.org/dist/kafka/3.3.1/kafka_2.13-3.3.1.tgz"

curl -L "$KAFKA_URL" -o kafka.tgz

sha256sum -c <(echo "$KAFKA_SHA256 kafka.tgz")

rm -rf "$INSTALL_DIR"
mkdir "$INSTALL_DIR"

tar xf kafka.tgz -C "$INSTALL_DIR" --strip-components=1
