# Cache-warmer image for the forgejo-cache-warmer DaemonSet.
#
# The base MUST stay the exact dockerd the runner's dind init container uses
# (docker:24.0.7-dind), digest-pinned to its linux/arm64 manifest so the
# warmed data-root metadata is adopted instead of rejected on driver or
# version mismatch. Only yq and mc are added on top.
FROM docker:24.0.7-dind@sha256:ed35ca2385c823eff0085766197dcad0bcd8863cfa704d2fe53e6d8630e0c771

# yq: parses .forgejo/workflows YAML for `uses:` discovery in warm.sh.
# Checksum-pinned: a silently shifted upstream release must fail the build.
RUN wget -q -O /tmp/yq.tgz \
      "https://github.com/mikefarah/yq/releases/download/v4.44.3/yq_linux_arm64.tar.gz" \
 && tar -xzf /tmp/yq.tgz -C /usr/local/bin ./yq_linux_arm64 \
 && mv /usr/local/bin/yq_linux_arm64 /usr/local/bin/yq \
 && chmod +x /usr/local/bin/yq \
 && rm -f /tmp/yq.tgz \
 && echo "0e7e1524f68d91b3ff9b089872d185940ab0fa020a5a9052046ef10547023156  /usr/local/bin/yq" | sha256sum -c -

# mc: SeaweedFS S3 mirror for the canonical act-cache store.
RUN wget -q -O /usr/local/bin/mc \
      "https://github.com/minio/mc/releases/download/RELEASE.2025-08-13T08-35-41Z/mc.linux-arm64.RELEASE.2025-08-13T08-35-41Z" \
 && chmod +x /usr/local/bin/mc \
 && echo "14c8c9616cfce4636add161304353244e8de383b2e2752c0e9dad01d4c27c12c  /usr/local/bin/mc" | sha256sum -c -

# git/fuse-overlayfs are deliberately NOT baked: warm.sh's existing
# `apk add --no-cache git fuse-overlayfs` line is the script's established
# convention and costs ~1s once per pod. Keeping it also means the script
# stays self-describing about what it needs at runtime.
