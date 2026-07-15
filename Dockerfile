FROM debian:trixie
ARG TARGETARCH

# Install requirements
RUN apt-get clean && \
    apt-get update && \
    apt-get upgrade -y && \
    apt-get install libc6 libdbus-1-3 libstdc++6 -y && \
    apt-get install tftp-hpa unzip arp-scan net-tools telnet -y

# Install app
COPY binaries/ /binaries
COPY run.sh /

RUN case "${TARGETARCH:-amd64}" in \
        arm) ARCH_MAP="arm" ;; \
        arm64) ARCH_MAP="arm64" ;; \
        amd64) ARCH_MAP="x64" ;; \
        386) ARCH_MAP="x86" ;; \
        *) echo "Unsupported architecture: ${TARGETARCH}" && exit 1 ;; \
    esac && \
    QBUS_DIR="/opt/qbusmqttgw" && \
    mkdir -p ${QBUS_DIR}/data && \
    mkdir -p /var/log/qbusmqttgw && \
    chmod a+r /var/log/qbusmqttgw && \
    cp /binaries/bin-${ARCH_MAP}/qbusMqttGw ${QBUS_DIR}/ && \
    cp -R /binaries/fw/ ${QBUS_DIR}/ && \
    cp /binaries/puttftp ${QBUS_DIR}/ && \
    chmod +x ${QBUS_DIR}/qbusMqttGw && \
    chmod +x ${QBUS_DIR}/puttftp && \
    chmod a+x /run.sh && \
    rm -rf /binaries

CMD [ "/run.sh" ]
