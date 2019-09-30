# !/bin/bash
#
# Configure your iptables to allow IP access only from Cloudflare.
# For users whose HTTP server is directly exposed to the host 80/443
#
# author: kingcc <eof@null.net>

iptables  -N cloudflare-only
ip6tables -N cloudflare-only

iptables  -A INPUT -p tcp -m multiport --dports http,https -j cloudflare-only
ip6tables -A INPUT -p tcp -m multiport --dports http,https -j cloudflare-only

# https://www.cloudflare.com/ips
for i in `curl https://www.cloudflare.com/ips-v4`; do
	iptables  -A cloudflare-only -s $i -j RETURN;
done
for i in `curl https://www.cloudflare.com/ips-v6`; do
	ip6tables -A cloudflare-only -s $i -j RETURN; 
done

# Log and discard network packets
iptables  -A cloudflare-only -j LOG --log-prefix  "IPTABLES_CLOUDFLARE_ONLY_BANNED: "
ip6tables -A cloudflare-only -j LOG --log-prefix "IP6TABLES_CLOUDFLARE_ONLY_BANNED: "
iptables  -A cloudflare-only -j DROP
ip6tables -A cloudflare-only -j DROP