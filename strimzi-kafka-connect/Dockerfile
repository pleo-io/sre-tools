FROM quay.io/strimzi/kafka:0.39.0-kafka-3.5.1
LABEL maintainer="SRE Team <sre@pleo.io>"

USER root:root
RUN mkdir -p /opt/kafka/plugins/debezium
RUN curl https://repo1.maven.org/maven2/io/debezium/debezium-connector-postgres/2.4.1.Final/debezium-connector-postgres-2.4.1.Final-plugin.tar.gz | tar xvz
RUN cp -R debezium-connector-postgres/* /opt/kafka/plugins/debezium
USER 1001
