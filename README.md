SUMO Docker Base Image
======================

A Docker base image for the SUMO traffic simulation package.

> "Simulation of Urban MObility" (SUMO) is an open source, highly portable,
> microscopic and continuous road traffic simulation package designed to handle
> large road networks.

Run with Docker
-------------
```
docker run --rm -t -i -p 1234:1234 -v /some/local/path/to/your/data:/data farberg/sumo-docker
```

(This uses an automated build on Dockerhub: https://hub.docker.com/r/farberg/sumo-docker/).

See also:

* [SUMO Wiki](http://sumo.dlr.de/wiki/Main_Page)
* [SUMO on SourceForge](http://sourceforge.net/projects/sumo/)
* [SUMO Simmer package](https://github.com/similitude/sumo-simmer)
* More information about [Docker](https://www.docker.com/)

