SUMO Docker Base Image
======================

A Docker base image for the [SUMO](http://sumo.dlr.de/wiki/Main_Page) traffic simulation package. SUMO (Simulation of Urban MObility) is an open source, highly portable, microscopic and continuous road traffic simulation package designed to handle large road networks.

Run with Docker
-------------
This uses an automated build on Dockerhub: https://hub.docker.com/r/farberg/sumo-docker/ so you don't have to build the image for yourself.

This Dockerfile uses Docker's concept of [volumes](https://docs.docker.com/v1.10/engine/userguide/containers/dockervolumes/) where you make one or more folders on your host computer available inside the docker container. The paths of these volumes are specificed in the [Dockerfile](Dockerfile). In this case, you can make a folder on your host computer available as ```/data``` in the Docker container. 

For example, if you have your SUMO files stored in the folder ```/some/local/path/to/your/data``` on your host computer, you can "mount" this folder as follows: ``` -v /some/local/path/to/your/data:/data```. When passing command line arguments to SUMO, use ```/data``` instead of the real folder's name on your computer.

This command illustrates this:
```
docker run --rm -t -i -p 1234:1234 -v /some/local/path/to/your/data:/data farberg/sumo-docker
```

Control SUMO via TraCi
-------------

Use the following command if you want to control SUMO using the [Traffic Control Interface ](TraCI). This exposes SUMO's features on port 1234 via TCP/IP:
```
docker run -t -i --rm -p 1234:1234 -v /some/local/path/to/your/data:/data farberg/sumo-docker -c /data/cologne.sumocfg --remote-port 1234 -v
```

Java API for TraCI
-------------

A Java API for TraCI is available [here](https://github.com/egueli/TraCI4J). 

An example application that uses TraCI4J is available [here](https://github.com/pfisterer/sumo-traci-demo).

