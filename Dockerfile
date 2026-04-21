FROM cgr.dev/chainguard/wolfi-base:latest@sha256:70750dfde91b4c5804b4df269121253fbdff73a9122925c7acc067aa33f9f55e

# Metadata for organization and automation
ARG REVISION
ARG VERSION=latest
LABEL org.opencontainers.image.title="End-of-Life CLI" \
      org.opencontainers.image.description="A robust Bash-based CLI for interacting with the endoflife.date API." \
      org.opencontainers.image.authors="Petromir Dzhunev" \
      org.opencontainers.image.source="https://github.com/petromir/end-of-life-cli" \
      org.opencontainers.image.version="${VERSION}" \
      org.opencontainers.image.revision="${REVISION}"

# Install required dependencies
RUN apk add --no-cache \
    bash \
    curl \
    jq

# UID/GID above 10,000 avoids overlapping with privileged host users.
RUN addgroup -g 10001 -S eolgroup && \
    adduser -u 10001 -S eoluser -G eolgroup

# Copy the script into the image and set ownership
COPY --chown=eoluser:eolgroup end-of-life.sh /usr/local/bin/end-of-life.sh

# Make the script executable
RUN chmod +x /usr/local/bin/end-of-life.sh

# Switch to the non-root user
USER eoluser

# Define the entrypoint to allow passing arguments directly to the script
ENTRYPOINT ["end-of-life.sh"]

# Default command to show the main index
CMD ["index"]
