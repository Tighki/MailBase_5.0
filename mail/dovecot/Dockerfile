FROM debian:11

# Install Dovecot and required packages
RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y \
    dovecot-imapd \
    dovecot-pop3d \
    dovecot-mysql \
    dovecot-sieve \
    dovecot-managesieved \
    dovecot-lmtpd \
    rsyslog \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Create vmail user
RUN groupadd -g 1100 vmail && \
    useradd -d /mnt/mail -g 1100 -u 1100 vmail && \
    usermod -a -G dovecot vmail

# Create postfix user and group
RUN groupadd -g 1001 postfix && \
    useradd -g postfix -u 1001 postfix

# Create directories
RUN mkdir -p /mnt/mail \
    /var/log/dovecot \
    /mnt/mail/shared-folders \
    && chown -R vmail:vmail /mnt/mail \
    && chown -R vmail:dovecot /var/log/dovecot

# Create log files
RUN cd /var/log/dovecot && \
    touch main.log info.log debug.log lda-errors.log lda-deliver.log lmtp.log && \
    chown vmail:dovecot *.log

# Create startup script
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

EXPOSE 143 993 110 995 4190

ENTRYPOINT ["/entrypoint.sh"] 