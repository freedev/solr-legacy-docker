solr-legacy
===========

This project aims to help developers and newbies that would try an old version of Solr (pre ver. 5.0) in a Docker Environment 

### Prerequisite for the installation

 * [install Docker lastest](https://docs.docker.com/engine/installation/) version or Docker for Desktop

### Quick start

If you want start Solr 4.7.0 in a container start with:

    git clone https://github.com/freedev/solr-legacy-docker.git
    cd solr-legacy-docker
    ./build-images.sh
    ./start.sh

### Add your own solr core/collection 

Just copy you core into the directory

    data/solr-jetty-1/store/solr

