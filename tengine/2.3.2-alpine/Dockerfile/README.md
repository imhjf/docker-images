# Simple docker image of Tengine web server based on Alpine #
***

- [more about Tengine](http://tengine.taobao.org)
- [docs](http://tengine.taobao.org/documentation.html)

in this image added [Upstream check module](http://tengine.taobao.org/document/http_upstream_check.html)

to start just type something like that:
```
docker exec -it -d -v example.com.conf:/etc/nginx/conf.d/example.com.conf \
    -p "80:80" -p 443:443 registry.cn-hangzhou.aliyuncs.com/fancybull/tengine:2.3.2
```
or if you want rewrite nginx.conf you can type something like that:

```
docker exec -it -d -v example.com.conf:/etc/nginx/conf.d/example.com.conf \
    -v nginx.conf:/etc/nginx/nginx.conf \
    -p "80:80" -p 443:443 registry.cn-hangzhou.aliyuncs.com/fancybull/tengine:2.3.2
```


