# java_jar:8_server-jdk-alpine
FROM stakater/java8-alpine

ENV JVM_XMS="512m" \
  JVM_XMX="512m" \
  JVM_XMN="256m" \
  JVM_MSS="32m" \
  JVM_MSX="256m" \
  JPAGENT_ENABLED="false" \
  TIME_ZONE="Asia/Shanghai"

RUN sed -i 's/dl-cdn.alpinelinux.org/mirrors.aliyun.com/g' /etc/apk/repositories
RUN apk add --no-cache \
  # grab su-exec for easy step-down from root
  'su-exec>=0.2' 

RUN apk add --no-cache --update tzdata && cp /usr/share/zoneinfo/$TIME_ZONE /etc/localtime \
  && echo $TIME_ZONE > /etc/timezone \
  && apk del tzdata

RUN wget https://download-gcdn.ej-technologies.com/jprofiler/jprofiler_linux_11_1_4.tar.gz -P /tmp/ && \
  tar -xzf /tmp/jprofiler_linux_11_1_4.tar.gz -C /usr/local &&\
  rm /tmp/jprofiler_linux_11_1_4.tar.gz
# /usr/local/jprofiler11.1.4
ENV JPAGENT_PATH="-agentpath:/usr/local/jprofiler11.1.4/bin/linux-x64/libjprofilerti.so=port=8849,nowait"
EXPOSE 8849

WORKDIR /projects

COPY docker-entrypoint.sh /usr/local/bin/
ENTRYPOINT ["docker-entrypoint.sh"]

CMD ["1000", "1000", 'app.jar']

#docker build -t java_jar:8_server-jdk-alpine .