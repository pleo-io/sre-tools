FROM ubuntu:23.04
MAINTAINER Alex Humphreys <alex.humphreys@pleo.io>

ENV LC_ALL=C.UTF-8
ENV LANG=C.UTF-8
ENV DEBIAN_FRONTEND=noninteractive


# RUN npm install -g wscat
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
ENV CURLIE_FILE_NAME=curlie_"$CURLIE_VERSION"_linux_arm64.deb

ADD https://github.com/rs/curlie/releases/download/v$CURLIE_VERSION/$CURLIE_FILE_NAME /
RUN sha256sum $CURLIE_FILE_NAME | ack c50b80ae0451097242279e4e20001f775370ed0259e4c41ce59fefb5b05a15c8
RUN dpkg -i $CURLIE_FILE_NAME
RUN rm $CURLIE_FILE_NAME

ADD https://github.com/vi/websocat/releases/download/v1.9.0/websocat_linux64 /
RUN sha256sum websocat_linux64 | ack 9ab17a9e03cca60fbf00aa709a1df5d9fb99a4514240cf7fac390470d6022bc5
RUN mv /websocat_linux64 /usr/local/bin/websocat

RUN useradd -ms /bin/bash pleo

USER pleo
WORKDIR /home/pleo

# Set Datadog version to the Git commit SHA.
ARG github_sha
ENV DD_VERSION ${github_sha}
