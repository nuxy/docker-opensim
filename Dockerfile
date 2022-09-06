FROM mono

ARG VERSION=0.9.2.1
ENV version $VERSION

WORKDIR /opensim

RUN curl http://opensimulator.org/dist/opensim-${version}.tar.gz -s | tar xfz - --strip 1 -C /opensim

COPY OpenSim.ini /opensim/bin/OpenSim.ini
COPY Regions.ini /opensim/bin/Regions/Regions.ini

EXPOSE 9000

CMD [ "mono", "./OpenSim.exe"]
