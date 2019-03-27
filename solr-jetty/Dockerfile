FROM freedev/solr-base

MAINTAINER Vincenzo D'Amore <v.damore@gmail.com>

# add our user and group first to make sure their IDs get assigned consistently, regardless of whatever dependencies get added
RUN groupadd -r jetty && useradd -r -g jetty jetty

ENV JETTY_HOME /usr/local/jetty
ENV PATH $JETTY_HOME/bin:$PATH
RUN mkdir -p "$JETTY_HOME"
WORKDIR $JETTY_HOME

# ENV JETTY_VERSION 9.2.26.v20180806
# ENV JETTY_VERSION 7.6.21.v20160908
ENV JETTY_VERSION 8.1.10.v20130312
ENV JETTY_TGZ_URL https://repo1.maven.org/maven2/org/eclipse/jetty/jetty-distribution/$JETTY_VERSION/jetty-distribution-$JETTY_VERSION.tar.gz

# GPG Keys are personal keys of Jetty committers (see https://github.com/eclipse/jetty.project/blob/0607c0e66e44b9c12a62b85551da3a0edce0281e/KEYS.txt)

RUN set -xe \
	&& curl -SL "$JETTY_TGZ_URL" -o jetty.tar.gz \
	&& tar -xvf jetty.tar.gz --strip-components=1 \
	&& sed -i '/jetty-logging/d' etc/jetty.conf \
	&& rm -fr demo-base javadoc \
	&& rm jetty.tar.gz* \
	&& rm -rf /tmp/hsperfdata_root

ENV JETTY_BASE /var/lib/jetty
RUN mkdir -p "$JETTY_BASE"
RUN mkdir -p "$JETTY_BASE/etc"
RUN cp -r $JETTY_HOME/etc $JETTY_BASE/
RUN cp -r $JETTY_HOME/lib $JETTY_BASE/
RUN cp -r $JETTY_HOME/resources $JETTY_BASE/
# RUN cp -r $JETTY_HOME/etc/jetty.xml $JETTY_BASE/etc
RUN cp -r $JETTY_HOME/start.ini $JETTY_BASE/
WORKDIR $JETTY_BASE

ENV TMPDIR /tmp/jetty
RUN set -xe \
	&& mkdir -p "$TMPDIR" \
	&& chown -R jetty:jetty "$TMPDIR" \
	&& chown -R jetty:jetty "$JETTY_BASE"

COPY docker-entrypoint.sh generate-jetty-start.sh /

USER jetty
EXPOSE 8080
ENTRYPOINT ["/docker-entrypoint.sh"]
