FROM docker:24.0.7-dind

COPY dind/entrypoint.sh /usr/local/bin/dind-overlay-entrypoint.sh
RUN chmod +x /usr/local/bin/dind-overlay-entrypoint.sh

ENTRYPOINT ["/usr/local/bin/dind-overlay-entrypoint.sh"]
