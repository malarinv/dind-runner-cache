#!/bin/sh
set -e

# If /var/lib/docker-cache exists and /var/lib/docker-empty exists, set up OverlayFS:
if [ -d "/var/lib/docker-cache" ] && [ -d "/var/lib/docker-empty" ]; then
  echo "Setting up OverlayFS for DinD cache..."
  mkdir -p /var/lib/docker-empty/upper /var/lib/docker-empty/work /var/lib/docker
  mount -t overlay overlay \
    -o lowerdir=/var/lib/docker-cache,upperdir=/var/lib/docker-empty/upper,workdir=/var/lib/docker-empty/work \
    /var/lib/docker
  echo "OverlayFS mounted successfully on /var/lib/docker!"
fi

# MSS clamp for vcluster networking
iptables -t mangle -A OUTPUT -p tcp --tcp-flags SYN,RST SYN -j TCPMSS --set-mss 1200 || true
iptables -t mangle -A FORWARD -p tcp --tcp-flags SYN,RST SYN -j TCPMSS --set-mss 1200 || true

exec dockerd-entrypoint.sh "$@"
