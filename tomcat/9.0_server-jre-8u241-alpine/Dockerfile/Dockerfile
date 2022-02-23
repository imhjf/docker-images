FROM registry.cn-hangzhou.aliyuncs.com/fancybull/java:8_server-jre-alpine       
 
# 定义tomcat变量(如果有其他的可以在这里加)
ENV CATALINA_HOME /opt/tomcat
ENV PATH $CATALINA_HOME/bin:$PATH

# 定义tomcat版本
ENV TOMCAT_MAJOR 9
ENV TOMCAT_VERSION 9.0.56
 
# 下载
# https://issues.apache.org/jira/browse/INFRA-8753?focusedCommentId=14735394#comment-14735394
ENV TOMCAT_TGZ_URL https://mirrors.cnnic.cn/apache/tomcat/tomcat-$TOMCAT_MAJOR/v$TOMCAT_VERSION/bin/apache-tomcat-$TOMCAT_VERSION.tar.gz
# not all the mirrors actually carry the .asc files :'(
# ENV TOMCAT_ASC_URL https://mirrors.cnnic.cn/apache/tomcat/tomcat-$TOMCAT_MAJOR/v$TOMCAT_VERSION/bin/apache-tomcat-$TOMCAT_VERSION.tar.gz.asc
 
# let "Tomcat Native" live somewhere isolated
# ENV TOMCAT_NATIVE_LIBDIR $CATALINA_HOME/native-jni-lib
# ENV LD_LIBRARY_PATH ${LD_LIBRARY_PATH:+$LD_LIBRARY_PATH:}$TOMCAT_NATIVE_LIBDIR
 
# see http://archive.apache.org/dist/tomcat/tomcat-$TOMCAT_MAJOR/KEYS
# see also "update.sh" (https://github.com/docker-library/tomcat/blob/master/update.sh)

RUN sed -i 's/dl-cdn.alpinelinux.org/mirrors.aliyun.com/g' /etc/apk/repositories

# 安装
RUN set -x \
        && mkdir -p "$CATALINA_HOME" && cd $CATALINA_HOME \
        && apk update && apk add --no-cache gnupg \
        && set -ex \
        && apk add --no-cache --virtual .fetch-deps \
                ca-certificates \
                tar \
                openssl \
        && wget -O tomcat.tar.gz "$TOMCAT_TGZ_URL" \
        && tar -xvf tomcat.tar.gz --strip-components=1 \
        && rm bin/*.bat \
        && rm tomcat.tar.gz* 
# 

# 开发8080端口
EXPOSE 8080

WORKDIR $CATALINA_HOME

COPY docker-entrypoint.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/docker-entrypoint.sh
ENTRYPOINT ["docker-entrypoint.sh"]

# 执行命令
CMD ["catalina.sh", "run"]