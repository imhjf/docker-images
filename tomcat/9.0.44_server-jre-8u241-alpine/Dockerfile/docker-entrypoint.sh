#!/bin/bash
if [ -z "$TOMCAT_HTTP_PORT" ]
then 
  echo "Tomcat HTTP port not changed"
else 
  echo "Tomcat HTTP port set to $TOMCAT_HTTP_PORT"
  sed -i "s/port=\"[0-9]\+\" protocol=\"HTTP\/1.1\"/port=\"$TOMCAT_HTTP_PORT\" protocol=\"HTTP\/1.1\"/" $CATALINA_HOME/conf/server.xml
fi

if [ -z "$TOMCAT_AJP_PORT" ]
then 
  echo "Tomcat AJP port not changed"
else 
  echo "Tomcat AJP port set to $TOMCAT_AJP_PORT"
  sed -i "s/port=\"[0-9]\+\" protocol=\"AJP\/1.3\"/port=\"$TOMCAT_AJP_PORT\" protocol=\"AJP\/1.3\"/" $CATALINA_HOME/conf/server.xml
fi

if [ -z "$TOMCAT_SHD_PORT" ]
then 
  echo "Tomcat shutdown port not changed"
else 
  echo "Tomcat shutdown port set to $TOMCAT_SHD_PORT"
  sed -i "s/port=\"[0-9]\+\" shutdown=\"SHUTDOWN\"/port=\"$TOMCAT_SHD_PORT\" shutdown=\"SHUTDOWN\"/" $CATALINA_HOME/conf/server.xml
fi

$CATALINA_HOME/bin/catalina.sh run