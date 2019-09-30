# !/bin/bash
#
# Configuration your iptables to allow IP access only from Cloudflare.
#
# author: kingcc <eof@null.net>

iptables -N cloudflare-only

# Release local request
iptables -I DOCKER-USER 1 -j RETURN -s 10.0.0.0/8
iptables -I DOCKER-USER 2 -j RETURN -s 172.16.0.0/12
iptables -I DOCKER-USER 3 -j RETURN -s 192.168.0.0/16

# Filter cloudflare requests
iptables -I DOCKER-USER 4 -p tcp -m multiport --dports http,https -j cloudflare-only

# https://www.cloudflare.com/ips
for i in `curl https://www.cloudflare.com/ips-v4`; do
	iptables -A cloudflare-only -s $i -j RETURN;
done

# Log and discard network packets
iptables -A cloudflare-only -j LOG --log-prefix "IPTABLES_CLOUDFLARE_ONLY_BANNED: "
iptables -A cloudflare-only -j DROP