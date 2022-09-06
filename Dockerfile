FROM mono

ARG VERSION=0.9.2.1
ENV version $VERSION

WORKDIR /opensim

RUN curl http://opensimulator.org/dist/opensim-${version}.tar.gz -s | tar xfz - --strip 2 -C /opensim opensim-${version}/bin

COPY OpenSim.ini /opensim/OpenSim.ini
COPY Regions.ini /opensim/Regions/Regions.ini

EXPOSE 9000

CMD ["mono", "./OpenSim.exe", "-background", "true"]
