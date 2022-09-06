# docker-opensim

[Open Simulator](http://opensimulator.org/wiki/Main_Page) server (pre-configured).

## Dependencies

- [Docker](https://docs.docker.com/get-docker)

## Starting the container

    $ docker build -t opensim .
    $ docker run --name=opensim -p 9000:9000 -p 9000:9000/udp -d opensim
