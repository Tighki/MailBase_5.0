FROM debian:11

# Install Postfix and required packages
RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y \
    postfix \
    postfix-mysql \
    ca-certificates \
    rsyslog \
    openssl \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Create vmail user
RUN groupadd -g 1100 vmail && \
    useradd -d /mnt/mail -g 1100 -u 1100 vmail

# Create directories
RUN mkdir -p /etc/postfix/mysql \
    /etc/postfix/certs \
    /mnt/mail \
    && chown vmail:vmail /mnt/mail

# Create startup script
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

EXPOSE 25 587 465

ENTRYPOINT ["/entrypoint.sh"] 