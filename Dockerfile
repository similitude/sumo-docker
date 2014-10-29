FROM debian:wheezy

MAINTAINER Oliver Lade <oliver@similitude.org>
# See http://sumo.dlr.de/wiki/Installing/Linux_Build

ENV SUMO_VERSION 0.21.0
ENV SUMO_SRC sumo-src-$SUMO_VERSION
ENV SUMO_HOME /opt/sumo

# Install system dependencies.
RUN apt-get update && apt-get install -qq \
    wget \
    g++ \
    make \
    libxerces-c3.1 \
    libxerces-c3-dev \
    python

# Download and extract the source code.
RUN wget http://downloads.sourceforge.net/project/sumo/sumo/version%20$SUMO_VERSION/$SUMO_SRC.tar.gz && \
    tar xzf $SUMO_SRC.tar.gz && \
    mv $SUMO_SRC $SUMO_HOME && \
    rm $SUMO_SRC.tar.gz

# Configure and build from source.
RUN cd $SUMO_HOME && ./configure && make install

# Ensure the installation works. If this call fails, the whole build will fail.
RUN sumo

