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
        armv7|armhf) ARCH_MAP="arm" ;; \
        aarch64) ARCH_MAP="arm64" ;; \
        amd64) ARCH_MAP="x64" ;; \
        i386) ARCH_MAP="x86" ;; \
        *) echo "Unsupported architecture: ${TARGETARCH}" && exit 1 ;; \
    esac && \
    mkdir -p /opt/ubielite && \
    mkdir -p /var/log/ubielite && \
    chmod a+r /var/log/ubielite && \
    cp /binaries/UbieLite-${ARCH_MAP}/UbieLite /opt/ubielite/ && \
    cp -R /binaries/fw/ /opt/ubielite/ && \
    cp /binaries/puttftp /opt/ubielite/ && \
    chmod +x /opt/ubielite/UbieLite && \
    chmod +x /opt/ubielite/puttftp && \
    chmod a+x /run.sh && \
    rm -rf /binaries

CMD [ "/run.sh" ]
