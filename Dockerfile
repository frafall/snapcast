#
# Build Snapserver for Alpine Linux
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
