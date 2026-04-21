#!/bin/bash
set -e

/usr/bin/caddy validate --config /etc/caddy/Caddyfile

/usr/sbin/sshd -D &
/usr/bin/caddy run --config /etc/caddy/Caddyfile --adapter caddyfile