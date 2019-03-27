#!/bin/bash

export SOLR_VERSION=4.7.0

mantainer_name=freedev

DOCKER_BIN=docker

$DOCKER_BIN build -t ${mantainer_name}/unix-utils unix-utils

$DOCKER_BIN build -t ${mantainer_name}/solr-base solr-base

$DOCKER_BIN build -t ${mantainer_name}/solr-jetty solr-jetty

