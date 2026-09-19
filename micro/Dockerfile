FROM ubuntu:22.04
ENV DEBIAN_FRONTEND=noninteractive
ENV DOCKER_BUILDKIT=1
ENV BUILDKIT_PROGRESS=plain

RUN apt-get update && apt-get install -y --no-install-recommends \
    ca-certificates \
    curl \
    git \
    jq \
    tar \
    gzip \
    unzip \
    xz-utils \
    sudo \
    && rm -rf /var/lib/apt/lists/*

# Docker CLI to interact with DinD socket
COPY --from=docker:24.0.7-cli /usr/local/bin/docker /usr/local/bin/docker

# Node.js 20 runtime for GitHub/Forgejo Actions Javascript actions
COPY --from=node:20-bookworm-slim /usr/local/bin/node /usr/local/bin/node

# Ensure node and docker are executable
RUN chmod +x /usr/local/bin/node /usr/local/bin/docker

CMD ["/bin/bash"]
