#!/bin/sh
set -e

user=jar
group=jar                                                                                                                                                                                                         
user_id=$1
group_id=$2                                                                                                                                                                                       

if ! id "${user}" > /dev/null 2>&1; then   
  addgroup -S -g ${group_id} ${group} && adduser -S -G ${group} -u ${user_id} ${user}                                                                                                                                                               
fi                                                                                                                                                                                                               
                                                                                                                                                          
chown -R ${user}:${group} /projects                                                                                                                                                                       

# allow the container to be started with `--user`
exec su-exec jar java -agentpath:/usr/local/jprofiler11.1.4/bin/linux-x64/libjprofilerti.so=port=8849,nowait -jar "$3" "$4" 
exec "$@"