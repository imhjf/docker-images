FROM registry.cn-hangzhou.aliyuncs.com/fancybull/alpine:3.11

LABEL maintainer="Maintainers <hongjinfeng@fancybull.cn>"

ENV NGINX_VERSION 1.17.10

RUN set -x && \
    GPG_KEYS=B0F4253373F8F6F510D42178520A9993A1C052F8 && \
    apk add --update --no-cache --virtual .build-deps \
        gcc \
        libc-dev \
        make \
        openssl-dev \
        pcre-dev \
        zlib-dev \
        linux-headers \
        curl \
        gnupg \
        libxslt-dev \
        gd-dev \
        geoip-dev && \
    cd /tmp && \
    curl -o /tmp/nginx.tar.gz https://nginx.org/download/nginx-${NGINX_VERSION}.tar.gz && \
    curl -o nginx.tar.gz.asc https://nginx.org/download/nginx-${NGINX_VERSION}.tar.gz.asc && \
    export GNUPGHOME="$(mktemp -d)" && \
    found=''; \
    for server in \
        ha.pool.sks-keyservers.net \
        hkp://keyserver.ubuntu.com:80 \
        hkp://p80.pool.sks-keyservers.net:80 \
        pgp.mit.edu \
    ; do \
        echo "Fetching GPG key $GPG_KEYS from $server"; \
        gpg --keyserver "$server" --keyserver-options timeout=10 --recv-keys "$GPG_KEYS" && found=yes && break; \
    done; \
    test -z "$found" && echo >&2 "error: failed to fetch GPG key $GPG_KEYS" && exit 1; \
    gpg --batch --verify nginx.tar.gz.asc nginx.tar.gz && \
    tar -xf nginx.tar.gz && \
    cd nginx-${NGINX_VERSION} && \
    sed -i 's/#define nginx_version      1017010/#define nginx_version      1000001/g' src/core/nginx.h && \
    sed -i 's/#define NGINX_VERSION      "1.17.10"/#define NGINX_VERSION      "1.00.01"/g' src/core/nginx.h && \
    sed -i 's/#define NGINX_VER          "nginx\/" NGINX_VERSION/#define NGINX_VER          "fanci\/" NGINX_VERSION/g' src/core/nginx.h && \
    sed -i 's/#define NGINX_VAR          "NGINX"/#define NGINX_VAR          "FANCI"/g' src/core/nginx.h && \
    sed -i 's/static u_char ngx_http_server_string\[\] = "Server: nginx" CRLF;/static u_char ngx_http_server_string\[\] = "Server: fanci" CRLF;/g' src/http/ngx_http_header_filter_module.c && \
    sed -i 's/"<hr><center>nginx<\/center>" CRLF/"<hr><center>fanci<\/center>" CRLF/g' src/http/ngx_http_special_response.c && \
    ./configure \
        --prefix=/nginx \
        --user=nginx \
        --group=nginx \
        --with-http_stub_status_module \
        --with-http_ssl_module && \
    make -j 4 && make install \
# Bring in gettext so we can get `envsubst`, then throw
# the rest away. To do this, we need to install `gettext`
# then move `envsubst` out of the way so `gettext` can
# be deleted completely, then move `envsubst` back.
    && apk add --no-cache --virtual .gettext gettext \
    && mv /usr/bin/envsubst /tmp/ \
    \
    && runDeps="$( \
        scanelf --needed --nobanner /nginx/sbin/nginx /tmp/envsubst \
            | awk '{ gsub(/,/, "\nso:", $2); print "so:" $2 }' \
            | sort -u \
            | xargs -r apk info --installed \
            | sort -u \
    )" \
    && apk add --no-cache $runDeps \
    && mv /tmp/envsubst /usr/local/bin/ \
    && apk del .build-deps \
    && apk del .gettext \
    && rm -rf /tmp/* \
    && rm -rf /nginx/html/*

STOPSIGNAL SIGTERM

WORKDIR /nginx

COPY docker-entrypoint.sh /usr/local/bin/
ENTRYPOINT ["docker-entrypoint.sh"]