FROM mono

ARG VERSION=0.9.2.1
ARG RUNCMD=

WORKDIR /usr/games

RUN curl "http://opensimulator.org/dist/opensim-${VERSION}.tar.gz" -s | tar xfz - --strip 2 -C /usr/games "opensim-${VERSION}/bin"

COPY config/OpenSim.ini /usr/games/OpenSim.ini
COPY config/Regions.ini /usr/games/Regions/Regions.ini
COPY init.d/game-server /etc/init.d/game-server

# Limit permissions to games group.
RUN chown -R games:games /usr/games

# Install LSB init and RC scripts.
RUN update-rc.d game-server defaults && echo "RUNCMD='$RUNCMD'" > .game-server

EXPOSE 9000

CMD service game-server start & sleep infinity
