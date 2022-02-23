FROM python:3.7-alpine

# ENV TIME_ZONE Asia/Shanghai
# ENV PIPURL "https://pypi.tuna.tsinghua.edu.cn/simple"

# RUN echo http://mirrors.aliyun.com/alpine/v3.9/main > /etc/apk/repositories && \
#     echo http://mirrors.aliyun.com/alpine/v3.9/community >> /etc/apk/repositories && \
#     apk --update add --no-cache g++ gcc tzdata libffi-dev libxslt-dev jpeg-dev libressl-dev musl-dev libffi-dev && \
#     ln -sf /usr/share/zoneinfo/${TIME_ZONE} /etc/localtime && echo "${TIME_ZONE}" > /etc/timezone
RUN apk add --no-cache tzdata && \
    cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime && \
    echo "Asia/Shanghai" > /etc/timezone