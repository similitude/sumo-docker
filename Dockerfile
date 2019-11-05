FROM maven:3

ENV SUMO_VERSION 1.3.1
ENV SUMO_SRC sumo-src-$SUMO_VERSION
ENV SUMO_HOME /opt/sumo

# Install system dependencies.
RUN apt-get update && apt-get install -qq \
    wget \
    g++ \
    cmake \
    libxerces-c3.1 \
    libxerces-c-dev \
    libgdal-dev \
    libproj-dev \
    libfox-1.6-dev\
    libgl2ps-dev\ 
    swig\
    python

# Download and extract source code
RUN wget https://sumo.dlr.de/releases/$SUMO_VERSION/sumo-src-$SUMO_VERSION.tar.gz
RUN tar xzf sumo-src-$SUMO_VERSION.tar.gz && \
    mv sumo-$SUMO_VERSION $SUMO_HOME && \
    rm sumo-src-$SUMO_VERSION.tar.gz

# Configure and build from source.
RUN cd $SUMO_HOME && mkdir build/cmake-build && \ 
    cd build/cmake-build && cmake ../.. && make -j $(nproc) && \
    make install

# Ensure the installation works. If this call fails, the whole build will fail.
RUN sumo

# Download and compile traci4j library
RUN apt-get install -qq -y ssh-client git
RUN mkdir -p /opt/traci4j 
WORKDIR /opt/traci4j
RUN git clone https://github.com/egueli/TraCI4J.git /opt/traci4j
RUN mvn package -f pom.xml -Dmaven.test.skip=true -Dmaven.compiler.source=1.6 -Dmaven.compiler.target=1.6

# Add volume to allow for host data to be used
RUN mkdir /data
VOLUME /data

# Expose a port so that SUMO can be started with --remote-port 1234 to be controlled from outside Docker
EXPOSE 1234

ENTRYPOINT ["sumo"]

CMD ["--help"]
