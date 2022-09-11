FROM mono

ARG VERSION=0.9.2.1
ARG RUNCMD=
ENV version $VERSION
ENV wine_prog $RUNCMD

WORKDIR /usr/games/opensim

COPY config/OpenSim.ini /usr/games/opensim/OpenSim.ini
COPY config/Regions.ini /usr/games/opensim/Regions/Regions.ini
COPY init.d/game-server /etc/init.d/game-server

RUN curl http://opensimulator.org/dist/opensim-${version}.tar.gz -s | tar xfz - --strip 2 -C /usr/games/opensim opensim-${version}/bin

# Limit permissions to games group.
RUN chown -R games:games /usr/games

# Install LSB init and RC scripts.
RUN update-rc.d game-server defaults && echo "${wine_prog}" > .runcmdrc

EXPOSE 9000

CMD service game-server start & sleep infinity
