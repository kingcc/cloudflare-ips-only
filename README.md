Cloudflare IPs Only
===================

Configure your iptables to allow IPs from Cloudflare only.

### Usage

For users whose HTTP server is directly exposed to host 80/443:

```sh
$ git clone https://github.com/kingcc/cloudflare-ips-only.git
$ cd cloudflare-ips-only
$ sudo bash ./host.sh
```

For users deployed with docker on server:

```sh
$ git clone https://github.com/kingcc/cloudflare-ips-only.git
$ cd cloudflare-ips-only
$ sudo bash ./docker.sh
```

### LICENCE

MIT
