#!/bin/bash

# Start rsyslog for logging
service rsyslog start

# Create dovecot socket directory if it doesn't exist
mkdir -p /var/run/dovecot
chown dovecot:dovecot /var/run/dovecot

# Create postfix socket directory for auth
mkdir -p /var/spool/postfix/private
chown postfix:postfix /var/spool/postfix/private 2>/dev/null || true

# Start Dovecot in foreground
exec dovecot -F 