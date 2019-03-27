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

docker kill $SOLR_HOSTNAME
docker ps -a | grep Exited | awk '{ print $1 }'  | xargs docker rm
