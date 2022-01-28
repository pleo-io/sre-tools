FROM ubuntu:22.04
MAINTAINER Alex Humphreys <alex.humphreys@pleo.io>

ENV LC_ALL=C.UTF-8
ENV LANG=C.UTF-8
ENV DEBIAN_FRONTEND=noninteractive

# RUN npm install -g wscat
RUN apt-get update && apt-get install -y \
  ack \
  curl \
  dnsutils \
  jq \
  mycli \
  mysql-client \
  netcat \
  openjdk-8-jre \
  pgcli \
  tzdata \
  unzip \
  vim

COPY install-kafka-tools.sh install-kafka-tools.sh

RUN /bin/bash -c ./install-kafka-tools.sh /opt/kafka

ADD https://github.com/BurntSushi/ripgrep/releases/download/0.10.0/ripgrep_0.10.0_amd64.deb /
RUN sha256sum ripgrep_0.10.0_amd64.deb | ack fae8c9dbe17998ce7d426bd3649fe71fd7c9eef0e9c2ac85e5958e2a70f665b8
RUN dpkg -i ripgrep_0.10.0_amd64.deb
RUN rm ripgrep_0.10.0_amd64.deb

ADD https://releases.hashicorp.com/vault/1.3.2/vault_1.3.2_linux_amd64.zip /
RUN sha256sum vault_1.3.2_linux_amd64.zip | ack 6e72132de0421b74d909f50be1823fe57182694c4268ba9a38c31213d9497ec9
RUN unzip vault_1.3.2_linux_amd64.zip -d /usr/local/bin/
RUN rm vault_1.3.2_linux_amd64.zip
RUN vault -autocomplete-install

ADD https://github.com/rs/curlie/releases/download/v1.6.7/curlie_1.6.7_linux_amd64.deb /
RUN sha256sum curlie_1.6.7_linux_amd64.deb | ack 28a18ff0d9337df8848de08e477d6f372485d5248bd679140a09467ce9f6558c
RUN dpkg -i curlie_1.6.7_linux_amd64.deb
RUN rm curlie_1.6.7_linux_amd64.deb

ADD https://github.com/vi/websocat/releases/download/v1.9.0/websocat_linux64 /
RUN sha256sum websocat_linux64 | ack 9ab17a9e03cca60fbf00aa709a1df5d9fb99a4514240cf7fac390470d6022bc5
RUN mv /websocat_linux64 /usr/local/bin/websocat

USER pleo

# Set Datadog version to the Git commit SHA.
ARG github_sha
ENV DD_VERSION ${github_sha}
WORKDIR /tmp
