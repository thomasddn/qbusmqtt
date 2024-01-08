FROM ubuntu:22.04
ARG TARGETARCH

COPY binaries/ /binaries
COPY run.sh /

RUN apt-get clean && \
    apt-get update && \
    apt-get upgrade -y && \
    apt-get install libc6 libdbus-1-3 libstdc++6 -y && \
    apt-get install tftp git unzip arp-scan net-tools telnet -y && \
    cd /binaries/qbusMqttGw && \
    tar -xf qbusMqttGw-${TARGETARCH:-amd64}.tar && \
    cd / && \
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