#!/bin/bash

set -e
set -u

INSTALL_DIR=${1:-/opt/kafka}
KAFKA_SHA256="2d73625aeddd827c9e92eefb3c727a78455725fbca4361c221eaa05ae1fab02d"
KAFKA_URL="https://archive.apache.org/dist/kafka/0.10.0.1/kafka_2.11-0.10.0.1.tgz"

curl -L $KAFKA_URL -o kafka.tgz

sha256sum -c <(echo "$KAFKA_SHA256 kafka.tgz")

rm -rf $INSTALL_DIR
mkdir $INSTALL_DIR

tar xf kafka.tgz -C $INSTALL_DIR --strip-components=1
