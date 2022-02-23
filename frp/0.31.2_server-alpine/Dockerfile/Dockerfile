FROM registry.cn-hangzhou.aliyuncs.com/fancybull/alpine:3.11

ENV FRP_VERSION 0.31.2

RUN set -ex \
    \
    && apk add --no-cache curl \
    && curl -o /tmp/frp.tar.gz -LJO https://github.com/fatedier/frp/releases/download/v${FRP_VERSION}/frp_${FRP_VERSION}_linux_amd64.tar.gz \
    && gunzip /tmp/frp.tar.gz && tar -C /tmp -xf /tmp/frp.tar \
    && mkdir -p /opt/frp && cd /opt/frp \
    && mv /tmp/frp_${FRP_VERSION}_linux_amd64/frps ./ \
    && mv /tmp/frp_${FRP_VERSION}_linux_amd64/frps.ini ./ \
    && rm -rf /tmp/* \
    && apk del curl

WORKDIR /opt/frp

CMD ./frps -c frps.ini