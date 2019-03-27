solr-legacy
===========

This project aims to help developers and newbies that would try an old version of Solr (pre ver. 5.0) in a Docker environment 

### Prerequisite for the installation

 * [install Docker](https://docs.docker.com/engine/installation/) latest version or Docker for Desktop

### Quick start

If you want start Solr 4.7.0 in a container start with:

    git clone https://github.com/freedev/solr-legacy-docker.git
    cd solr-legacy-docker
    ./build-images.sh
    ./start.sh

### Add your own solr core/collection 

Just copy you core into the directory

    data/solr-jetty-1/store/solr


### Choose the Solr Version

Just modify the `build.sh` file changing the `SOLR_VERSION` environment variable accordingly to the version you need

    export SOLR_VERSION=4.7.0

