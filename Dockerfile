FROM mono

ARG VERSION=0.9.2.1
ARG RUNCMD=

WORKDIR /usr/games

RUN apt -y update && apt -y install default-mysql-server
RUN curl "http://opensimulator.org/dist/opensim-${VERSION}.tar.gz" -s | tar xfz - --strip 2 -C /usr/games "opensim-${VERSION}/bin"

COPY config/OpenSim.ini /usr/games/OpenSim.ini
COPY config/Regions.ini /usr/games/Regions/Regions.ini
COPY config/StandaloneCommon.ini /usr/games/config-include/StandaloneCommon.ini

# Limit permissions to games group.
RUN chown -R games:games /usr/games

COPY init.d/game-server /etc/init.d/game-server
COPY launch.sh /usr/games/launch.sh

# Install LSB init and RC scripts.
RUN update-rc.d game-server defaults && echo "RUNCMD='$RUNCMD'" > .game-server

EXPOSE 9000

CMD /usr/games/launch.sh
