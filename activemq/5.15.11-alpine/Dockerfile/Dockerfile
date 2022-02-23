FROM registry.cn-hangzhou.aliyuncs.com/fancybull/java:8_server-jre-alpine

ENV ACTIVEMQ_VERSION 5.15.11
ENV ACTIVEMQ apache-activemq-$ACTIVEMQ_VERSION
ENV ACTIVEMQ_TCP=61616 ACTIVEMQ_AMQP=5672 ACTIVEMQ_STOMP=61613 ACTIVEMQ_MQTT=1883 ACTIVEMQ_WS=61614 ACTIVEMQ_UI=8161
ENV ACTIVEMQ_HOME /opt/activemq

RUN set -ex && \
    mkdir -p /opt && \
    apk add --update --no-cache --virtual .build-deps \
    curl \
    tar && \
    cd /tmp && \
    curl -o apache-activemq-$ACTIVEMQ_VERSION-bin.tar.gz https://archive.apache.org/dist/activemq/$ACTIVEMQ_VERSION/apache-activemq-$ACTIVEMQ_VERSION-bin.tar.gz && \
    echo "a3ca1a839ddb87eaf7468db1f130a1fe79be6423acc6b059ac2998d3d359b8cc369a45b62322bf29bb031e702113e4d1ac44ee43457a28e7bf22687aa107a37f  apache-activemq-5.15.11-bin.tar.gz"|sha512sum -c - && \
    tar -xf apache-activemq-$ACTIVEMQ_VERSION-bin.tar.gz && \
    mv apache-activemq-$ACTIVEMQ_VERSION $ACTIVEMQ_HOME && \
    apk del .build-deps && \
    rm -rf /tmp/*

WORKDIR $ACTIVEMQ_HOME
EXPOSE $ACTIVEMQ_TCP $ACTIVEMQ_AMQP $ACTIVEMQ_STOMP $ACTIVEMQ_MQTT $ACTIVEMQ_WS $ACTIVEMQ_UI

CMD /bin/sh $ACTIVEMQ_HOME/bin/activemq console