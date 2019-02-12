#
# Build Snapserver for Alpine Linux
#
# docker build -f Dockerfile -t frafall/snapserver:latest .
# docker run -d frafall/snapserver:latest
# 
# Config (cmd line, .config, pipe input)
#
ARG VERSION=latest
FROM alpine:$VERSION 
USER root

# Install runtime prereqs
RUN apk add -U --no-cache libressl2.7-libcrypto pulseaudio-libs \
    libvorbis flac alsa-lib avahi bash expat

# Copy buildt snapserver
COPY server/snapserver /usr/bin/snapserver

# Entrypoint and configuration
CMD ["/usr/bin/snapserver"]

