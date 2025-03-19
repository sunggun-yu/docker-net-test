FROM alpine:latest

# Install all required packages
RUN apk update && apk add --no-cache \
    apache2-utils \
    bash \
    bind-tools \
    busybox-extras \
    ca-certificates \
    curl \
    drill \
    iputils \
    iproute2 \
    iptables \
    jq \
    ipcalc \
    mtr \
    nano \
    net-tools \
    netcat-openbsd \
    nmap \
    openssl \
    procps \
    tcpdump \
    tcptraceroute \
    traceroute \
    vim \
    wget \
    whois \
    wrk \
    yq \
    && rm -rf /var/cache/apk/*

# Create a home directory for nobody user
RUN mkdir -p /home/nobody && \
    chown -R nobody:nobody /home/nobody

# Switch to the nobody user
# In Alpine, nobody has UID 65534
USER nobody
WORKDIR /home/nobody

# Set bash as the default shell
CMD ["bash"]
