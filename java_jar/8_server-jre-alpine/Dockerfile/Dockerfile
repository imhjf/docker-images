FROM registry.cn-hangzhou.aliyuncs.com/fancybull/java:8_server-jre-alpine	

RUN apk add --no-cache \
# grab su-exec for easy step-down from root
		'su-exec>=0.2' 

WORKDIR /projects

COPY docker-entrypoint.sh /usr/local/bin/
ENTRYPOINT ["docker-entrypoint.sh"]

CMD ["1000", "1000", 'app.jar']
