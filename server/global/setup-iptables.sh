#!/bin/bash

# +========= CLEAR EXISTING RULES ==========+
iptables -F
iptables -X
iptables -t nat -F
iptables -t nat -X
iptables -t mangle -F
iptables -t mangle -X

# +=========== DEFAULT POLICIES ============+
iptables -P INPUT DROP
iptables -P FORWARD DROP
iptables -P OUTPUT ACCEPT

# +============= CUSTOM RULES ==============+
# 1. ⛔ Deny access to port 80 (HTTP) from specific IP
iptables -I INPUT -p tcp --dport 80 -s 10.89.0.10 -j REJECT --reject-with tcp-reset

# 2. Block access to port 21 (FTP) from specific IP
iptables -I INPUT -p tcp --dport 21 -s 10.89.0.20 -j REJECT --reject-with tcp-reset

# 3. Deny outbound traffic to IP range 10.89.0.40 - 10.89.0.130
iptables -I FORWARD -m iprange --dst-range 10.89.0.40-10.89.0.130 -j DROP


# +============= BASIC RULES ==============+
iptables -A INPUT -i lo -j ACCEPT                                   # Loopback
iptables -A INPUT -p tcp --dport 3128 -j ACCEPT                     # Squid
iptables -A INPUT -p tcp --dport 80 -j ACCEPT                       # Nginx (general)
iptables -A INPUT -p udp --dport 53 -j ACCEPT                       # DNS UDP
iptables -A INPUT -p tcp --dport 53 -j ACCEPT                       # DNS TCP
iptables -A INPUT -p tcp --dport 21 -j ACCEPT                       # FTP port 21 allowed
iptables -A INPUT -p icmp --icmp-type echo-request -j ACCEPT        # Allow ping (ICMP echo-request)
iptables -A INPUT -m state --state ESTABLISHED,RELATED -j ACCEPT    # Established connections

# +============== DEBUGGING ===============+
iptables -L -v
iptables -S

# +=========== RUN SUPERVISORD ============+
exec "$@"
