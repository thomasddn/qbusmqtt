ARG TARGETARCH
ARG BUILD_FROM=ubuntu:22.04

# Using multi-stage as if/else conditions
# https://stackoverflow.com/questions/43654656/dockerfile-if-else-condition-with-external-arguments/60820156#60820156
FROM $BUILD_FROM as base
COPY binaries/ /binaries
COPY run.sh /
RUN apt-get clean && \
    apt-get update && \
    apt-get upgrade -y && \
    apt-get install libc6 libdbus-1-3 libstdc++6 -y && \
    apt-get install tftp git unzip arp-scan net-tools -y

# ARM
FROM base as armv7
RUN cd /binaries/qbusMqttGw \
    && tar -xf qbusMqttGw-arm.tar

# X64
FROM base as amd64
RUN cd /binaries/qbusMqttGw \
    && tar -xf qbusMqttGw-x64.tar

# FINAL
FROM $TARGETARCH AS final
RUN cd / && \
    mkdir /usr/bin/qbus && \
    mkdir /opt/qbus && \
    cp -R /binaries/fw/ /opt/qbus/ && \
    cp /binaries/puttftp /opt/qbus/ && \
    cp /binaries/qbusMqttGw/qbusMqttGw /usr/bin/qbus/ && \
    chmod +x /usr/bin/qbus/qbusMqttGw && \
    chmod +x /opt/qbus/puttftp && \
    chmod a+x /run.sh && \
    rm -rf /binaries

CMD [ "/run.sh" ]