FROM ubuntu:22.04
LABEL maintainer="Alex Humphreys <alex.humphreys@pleo.io>"

ENV LC_ALL=C.UTF-8
ENV LANG=C.UTF-8
ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y \
  ack \
  curl \
  dnsutils \
  gpg \
  jq \
  lsb-release \
  mycli \
  mysql-client \
  netcat-traditional \
  openjdk-8-jre \
  pgcli \
  ripgrep \
  tzdata \
  unzip \
  vim \
  wget

RUN wget -O- https://apt.releases.hashicorp.com/gpg | gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg
RUN echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" \
    | tee /etc/apt/sources.list.d/hashicorp.list

COPY install-kafka-tools.sh install-kafka-tools.sh

RUN apt-get update && apt-get install -y vault

RUN /bin/bash -c ./install-kafka-tools.sh /opt/kafka

ENV CURLIE_VERSION=1.7.1
ENV CURLIE_FILE_NAME=curlie_"$CURLIE_VERSION"_linux_amd64.deb

ADD https://github.com/rs/curlie/releases/download/v$CURLIE_VERSION/$CURLIE_FILE_NAME /
RUN sha256sum $CURLIE_FILE_NAME | ack c749d3749cdd920a6cb77c68c7b4bf807d18acb62c33d4283d2d15d727968509
RUN dpkg -i $CURLIE_FILE_NAME
RUN rm $CURLIE_FILE_NAME

ENV WEBSOCAT_FILE_NAME=websocat.arm-unknown-linux-musleabi
ADD https://github.com/vi/websocat/releases/download/v1.11.0/$WEBSOCAT_FILE_NAME /
RUN sha256sum $WEBSOCAT_FILE_NAME
RUN mv $WEBSOCAT_FILE_NAME /usr/local/bin/websocat

ENV AWSCLI_FILE_NAME=awscli-exe-linux-x86_64.zip
ADD https://awscli.amazonaws.com/$AWSCLI_FILE_NAME /
RUN sha256sum $AWSCLI_FILE_NAME
RUN unzip $AWSCLI_FILE_NAME && ./aws/install

RUN useradd -ms /bin/bash pleo

USER pleo
WORKDIR /home/pleo

# Set Datadog version to the Git commit SHA.
ARG github_sha
ENV DD_VERSION ${github_sha}
