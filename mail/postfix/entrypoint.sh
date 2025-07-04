#!/bin/bash

# Generate SSL certificates if they don't exist
if [ ! -f /etc/postfix/certs/cert.pem ] || [ ! -f /etc/postfix/certs/key.pem ]; then
    mkdir -p /etc/postfix/certs
    openssl req -new -x509 -days 3650 -nodes \
        -out /etc/postfix/certs/cert.pem \
        -keyout /etc/postfix/certs/key.pem \
        -subj "/C=RU/ST=Moscow/L=Moscow/O=FltrKTV/OU=IT/CN=mail.fltrktv.ru"
    chmod 644 /etc/postfix/certs/cert.pem
    chmod 600 /etc/postfix/certs/key.pem
fi

# Create tls_policy_maps if it doesn't exist
if [ ! -f /etc/postfix/tls_policy_maps ]; then
    touch /etc/postfix/tls_policy_maps
    postmap /etc/postfix/tls_policy_maps
fi

# Create bcc maps if they don't exist
if [ ! -f /etc/postfix/recipient_bcc_maps ]; then
    echo "@fltrktv.ru all_in@fltrktv.ru" > /etc/postfix/recipient_bcc_maps
    postmap /etc/postfix/recipient_bcc_maps
fi

if [ ! -f /etc/postfix/sender_bcc_maps ]; then
    echo "@fltrktv.ru all_out@fltrktv.ru" > /etc/postfix/sender_bcc_maps
    postmap /etc/postfix/sender_bcc_maps
fi

# Start rsyslog for logging
service rsyslog start

# Start Postfix in foreground
exec postfix start-fg 