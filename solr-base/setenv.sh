#!/bin/bash

export JAVA_OPTIONS=" \
-XX:NewRatio=3 \
-XX:SurvivorRatio=4 \
-XX:TargetSurvivorRatio=90 \
-XX:MaxTenuringThreshold=8 \
-XX:+UseConcMarkSweepGC \
-XX:+CMSScavengeBeforeRemark \
-XX:PretenureSizeThreshold=64m \
-XX:CMSFullGCsBeforeCompaction=1 \
-XX:+UseCMSInitiatingOccupancyOnly \
-XX:CMSInitiatingOccupancyFraction=70 \
-XX:CMSTriggerPermRatio=80 \
-XX:CMSMaxAbortablePrecleanTime=6000 \
-XX:+CMSParallelRemarkEnabled
-XX:+ParallelRefProcEnabled
-XX:+UseLargePages \
-XX:+AggressiveOpts \
-Dcom.sun.management.jmxremote.port=1616 \
-Dcom.sun.management.jmxremote.ssl=false \
-Dcom.sun.management.jmxremote.authenticate=false \
-Dsolr.allow.unsafe.resourceloading=true \
"

if [ "A" == "A$SOLR_JAVA_MEM" ]
then
  SOLR_JAVA_MEM="-Xms512m -Xmx1536m"
fi

if [ "A" == "A$SOLR_DATA" ]
then
  SOLR_DATA="/store/solr"
fi

if [ "A" == "A$SOLR_LOG_DIR" ]
then
  SOLR_LOG_DIR="/store/logs"
fi

export JAVA_OPTIONS="-Dport.http.nonssl=$SOLR_PORT -Dsolr.log=$SOLR_LOG_DIR -Dsolr.solr.home=$SOLR_DATA -Dhost='$SOLR_HOSTNAME' $SOLR_JAVA_MEM $JAVA_OPTIONS "

export JAVA_OPTIONS="-agentlib:jdwp=transport=dt_socket,server=y,address=8000,suspend=n $JAVA_OPTIONS"

