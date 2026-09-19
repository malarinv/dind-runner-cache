# DinD Runner Cache & Act Micro Images

This repository provides container images designed to accelerate ephemeral Forgejo / GitHub Actions runners running in Kubernetes (via KEDA `ScaledJob`):

## Images

### 1. `ghcr.io/malarinv/act-micro:latest`
A lightweight (~180MB) multi-arch (`linux/amd64`, `linux/arm64`) execution environment for Forgejo Actions (act).
- Based on Ubuntu 22.04 with minimal dependencies (`curl`, `git`, `jq`, `tar`, `gzip`, `unzip`, `sudo`).
- Pre-installed Node.js 20 runtime (for JavaScript GitHub actions like `actions/checkout` and `docker/login-action`).
- Pre-installed Docker CLI (to talk to `/var/run/docker.sock`).
- Pulls in **2–3 seconds** on fresh ephemeral runner pods compared to 45–90 seconds for full Ubuntu runner images.

### 2. `ghcr.io/malarinv/dind-runner-cache:latest`
A Docker-in-Docker (DinD) sidecar image with built-in OverlayFS cache mounting and MSS clamping for Kubernetes vcluster networks.
- Mounts an OverlayFS over `/var/lib/docker-cache` (lowerdir) and an ephemeral `emptyDir` (upperdir) at `/var/lib/docker`.
- Enables instant 0.0s image availability while still ensuring all ephemeral build data is wiped when the pod terminates.
