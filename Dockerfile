FROM debian:wheezy

MAINTAINER Oliver Lade <oliver@similitude.org>
# See http://sumo.dlr.de/wiki/Installing/Linux_Build

# Install system dependencies.
RUN apt-get update && apt-get install -qq \
    wget \
    g++ \
    make \
    libxerces-c3.1 \
    libxerces-c3-dev \
    python

# Download and extract the source code.
RUN wget http://downloads.sourceforge.net/project/sumo/sumo/version%200.21.0/sumo-src-0.21.0.tar.gz && \
    tar xzf sumo-src-0.21.0.tar.gz && \
    rm sumo-src-0.21.0.tar.gz

# Configure and build from source.
RUN cd sumo-0.21.0 && ./configure && make install

# Ensure the installation works. If this call fails, the whole build will fail.
RUN sumo

