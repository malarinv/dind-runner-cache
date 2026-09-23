FROM docker:24.0.7-dind

# fuse-overlayfs: fallback storage driver when nested kernel overlay mounts
# fail with EINVAL (overlay-on-overlay on tmpfs/xfs with unsupported opts).
# Without it dockerd falls back to vfs, which full-copies every image layer
# and blows the 4Gi dind limit / 30Gi emptyDir during heavy builds.
RUN apk add --no-cache fuse-overlayfs

COPY dind/entrypoint.sh /usr/local/bin/dind-overlay-entrypoint.sh
RUN chmod +x /usr/local/bin/dind-overlay-entrypoint.sh

ENTRYPOINT ["/usr/local/bin/dind-overlay-entrypoint.sh"]
