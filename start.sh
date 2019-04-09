#!/bin/bash

set -e

function my_readlink() {
  case "$OSTYPE" in
    solaris*) echo "SOLARIS" ;;
    darwin*)
       echo $( cd "$1" ; pwd -P )
       ;;
    linux*)
       echo $(readlink -f $1)
        ;;
    bsd*)     echo "BSD" ;;
    *)        echo "unknown: $OSTYPE" ;;
  esac
}

PWD=$(pwd)
PWD_PATH=$(my_readlink $PWD)
SCRIPT_PATH=$(my_readlink $(dirname "$0"))
SCRIPT_NAME=$(basename "$0")
SCRIPT_DIR=$(dirname $SCRIPT_PATH)

SZD_HOME=$SCRIPT_PATH

source $SZD_HOME/config/common.sh

[ -z "$SZD_HOME" ] && echo "ERROR: "\$SZD_HOME" environment variable not found!" && exit 1;

if [ -z "$SZD_DATA_DIR" ]
then
	export SZD_DATA_DIR=$SZD_HOME/data
	if [ ! -d $SZD_HOME/data ]
	then
		mkdir $SZD_HOME/data
	fi
fi

if [ ! -d $SZD_DATA_DIR ]
then
	echo "ERROR: "$SZD_DATA_DIR" unable to access contaners data dir!"
	exit 1
fi

export SZD_CONFIG_DIR=$SZD_DATA_DIR/config

if [ ! -d $SZD_CONFIG_DIR ]
then
	echo "INFO: "$SZD_CONFIG_DIR" not found, creating..."
	mkdir -p $SZD_CONFIG_DIR
fi

export DOCKER_BIN="sudo docker"

if [ "A$SZD_HOME" == "A" ]
then
        echo "ERROR: "\$SZD_HOME" environment variable not found!"
        exit 1
fi

HOST_DATA_DIR=$SZD_DATA_DIR/${SOLR_HOSTNAME}

if [ ! -f ${HOST_DATA_DIR}/store/logs ] ; then
    mkdir -p ${HOST_DATA_DIR}/store/logs
fi

if [ ! -f ${HOST_DATA_DIR}/store/solr/solr.xml ] ; then
    mkdir -p ${HOST_DATA_DIR}/store/solr
    cp $SZD_HOME/config/solr.xml ${HOST_DATA_DIR}/store/solr
fi

if [ ! -d ${HOST_DATA_DIR} ] ; then
    echo "Error: unable to create "$HOST_DATA_DIR
    exit
fi

container_id=$(  $DOCKER_BIN run -d \
	-e SOLR_JAVA_MEM="-Xms512m -Xmx1536m" \
	-e SOLR_HOSTNAME="${SOLR_HOSTNAME}" \
	-e SOLR_DATA=/store/solr \
	-e SOLR_LOG_DIR=/store/logs \
	-v "$HOST_DATA_DIR/store:/store" \
	-p ${SOLR_PORT}:8080 \
	--name "${SOLR_HOSTNAME}" \
	${mantainer_name}/${container_name} java -jar /usr/local/jetty/start.jar )

# docker run -e JAVA_OPTIONS="-Xmx1g" freedev/jetty java -jar /usr/local/jetty/start.jar

  container_ip=$($DOCKER_BIN inspect --format '{{.NetworkSettings.IPAddress}}' ${SOLR_HOSTNAME})
  line="${container_ip} ${SOLR_HOSTNAME}"
  HOSTS_CLUSTER="${HOSTS_CLUSTER}"$'\n'"${line}"$'\n'

  echo "Starting container: ${SOLR_HOSTNAME} ($container_ip) on port: ${SOLR_PORT} ..."

echo "Solr ready:"
echo ${HOSTS_CLUSTER}

