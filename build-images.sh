#!/bin/bash

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

DOCKER_BIN=docker

$DOCKER_BIN build -t ${mantainer_name}/unix-utils unix-utils

$DOCKER_BIN build -t ${mantainer_name}/solr-base --build-arg SOLR_VERSION=$SOLR_VERSION solr-base

$DOCKER_BIN build -t ${mantainer_name}/solr-jetty solr-jetty

