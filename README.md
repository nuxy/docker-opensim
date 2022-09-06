# docker-opensim-server

[Open Simulator](http://opensimulator.org/wiki/Main_Page) server (pre-configured).

## Dependencies

- [Visual Studio Code](https://code.visualstudio.com/download) (optional)
- [Docker](https://docs.docker.com/get-docker)

### VS Code extensions

- [Remote-Containers](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.remote-containers)

## Manually starting the container

    $ docker build -t opensim .
    $ docker run --name=opensim -p 9000:9000 -p 9000:9000/udp -d opensim

## Launching in Remote-Containers

In the VS Code _Command Palette_ choose "Open Folder in Container" which will launch the server in a Docker container allowing for realtime development and testing.  Once launched, the server can be accessed using an [OpenSim viewer](http://opensimulator.org/wiki/Compatible_Viewers#Viewers) at - [http://localhost:9000](http://localhost:9000)
