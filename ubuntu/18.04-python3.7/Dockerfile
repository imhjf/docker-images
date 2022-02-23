FROM ubuntu:20.04

ENV DEBIAN_FRONTEND=noninteractive

RUN set -x && \
    apt-get update -y && \
    apt-get install -y python3 python3-pip python3-dev tzdata && \
    ln -s /usr/bin/python3.8 /usr/bin/python && \
    ln -s /usr/bin/pip3 /usr/bin/pip && \
    ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime && \
    apt-get clean
