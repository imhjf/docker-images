#!/bin/sh
set -e

user=nginx
group=nginx                                                                                                                                                                                                         
user_id=$1
group_id=$2                                                                                                                                                                                       

if ! id "${user}" > /dev/null 2>&1; then   
  addgroup -S -g ${group_id} ${group} && adduser -S -G ${group} -u ${user_id} ${user}                                                                                                                                                               
fi                                                                                                                                                                                                               
                                                                                                                                                          
chown -R ${user}:${group} /nginx                                                                                                                                                                       

# allow the container to be started with `--user`
exec /nginx/sbin/nginx -g 'daemon off;'
exec "$@"