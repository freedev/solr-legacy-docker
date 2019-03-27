FROM freedev/unix-utils

MAINTAINER Vincenzo D'Amore <v.damore@gmail.com>

ARG SOLR_VERSION

ENV SOLR_VERSION=$SOLR_VERSION

ENV SOLR_HOME /var/lib/solr

WORKDIR $SOLR_HOME

USER root

RUN mkdir -p $SOLR_HOME && mkdir -p /var/lib/jetty/webapps/ && \
    mkdir -p /var/lib/jetty/lib/ext && \
    curl -SL http://archive.apache.org/dist/lucene/solr/$SOLR_VERSION/solr-$SOLR_VERSION.tgz  \
    | tar -xz -C $SOLR_HOME --strip-components=1 && \
    mv $SOLR_HOME/dist/solr-$SOLR_VERSION.war /var/lib/jetty/webapps/solr.war && \
    cp -r $SOLR_HOME/dist/solr-core-$SOLR_VERSION.jar /var/lib/jetty/lib/ext/ && \
    cp -r $SOLR_HOME/dist/solr-solrj-$SOLR_VERSION.jar /var/lib/jetty/lib/ext/ && \
    cp -r $SOLR_HOME/dist/solrj-lib/* /var/lib/jetty/lib/ext/ && \
    rm -rf $SOLR_HOME

ADD setenv.sh /var/lib/jetty
