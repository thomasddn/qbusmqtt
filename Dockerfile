FROM debian:bookworm
ARG TARGETARCH

# Install requirements
RUN apt-get clean && \
    apt-get update && \
    apt-get upgrade -y && \
    apt-get install libc6 libdbus-1-3 libstdc++6 -y && \
    apt-get install tftp unzip arp-scan net-tools telnet -y

# Install app
COPY binaries/ /binaries
COPY run.sh /

RUN case "${TARGETARCH:-amd64}" in \
        arm) ARCH_MAP="arm" ;; \
        amd64) ARCH_MAP="x64" ;; \
        386) ARCH_MAP="x86" ;; \
        *) echo "Unsupported architecture: ${TARGETARCH}" && exit 1 ;; \
    esac && \
    mkdir -p /opt/qbusmqttgw && \
    mkdir -p /var/log/qbusmqttgw && \
    chmod a+r /var/log/qbusmqttgw && \
    cp /binaries/gateway-${ARCH_MAP}/qbusMqttGw /opt/qbusmqttgw/ && \
    cp -R /binaries/fw/ /opt/qbusmqttgw/ && \
    cp /binaries/puttftp /opt/qbusmqttgw/ && \
    chmod +x /opt/qbusmqttgw/qbusMqttGw && \
    chmod +x /opt/qbusmqttgw/puttftp && \
    chmod a+x /run.sh && \
    rm -rf /binaries

CMD [ "/run.sh" ]
