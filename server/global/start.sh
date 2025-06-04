#!/bin/bash

# Setup DNS
/usr/local/bin/setup-dns.sh

# Setup iptables
/usr/local/bin/setup-iptables.sh

# Start supervisord
exec /usr/bin/supervisord -n
