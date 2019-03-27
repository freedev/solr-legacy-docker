#!/bin/bash

set -e

docker kill solr-jetty-1
docker ps -a | grep Exited | awk '{ print $1 }'  | xargs docker rm
