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

#===========================================================================================
# JVM Configuration
#===========================================================================================
JAVA_OPT="${JAVA_OPT} -Xms${JVM_XMS} -Xmx${JVM_XMX} -Xmn${JVM_XMN} -server -XX:MetaspaceSize=${JVM_MSS} -XX:MaxMetaspaceSize=${JVM_MSX} -XX:NewRatio=1 -XX:+UseParNewGC -XX:+UseConcMarkSweepGC -XX:-UseGCOverheadLimit -XX:-OmitStackTraceInFastThrow -XX:+HeapDumpOnOutOfMemoryError -verbose:gc -XX:+PrintGCDetails -XX:+PrintGCDateStamps -Xloggc:gc.log"
if [[ "${JPAGENT_ENABLED}" == "true" ]]; then
  JAVA_OPT="${JAVA_OPT} -agentpath:/usr/local/jprofiler11.1.4/bin/linux-x64/libjprofilerti.so=port=8849,nowait"
fi

# allow the container to be started with `--user`
echo "${JAVA_OPT}"
exec su-exec jar java ${JAVA_OPT} -jar "$3" "$4" 
exec "$@"