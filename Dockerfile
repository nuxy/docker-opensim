FROM mono

ARG VERSION=0.9.2.1
ENV version $VERSION

WORKDIR /usr/games/opensim

RUN curl http://opensimulator.org/dist/opensim-${version}.tar.gz -s | tar xfz - --strip 2 -C /usr/games/opensim opensim-${version}/bin

COPY config/OpenSim.ini /usr/games/opensim/OpenSim.ini
COPY config/Regions.ini /usr/games/opensim/Regions/Regions.ini

EXPOSE 9000

CMD ["mono", "./OpenSim.exe", "-background", "true"]
