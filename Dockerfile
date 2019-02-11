#
# Build Snapserver for Alpine Linux
#
ARG VERSION=latest
FROM alpine:$VERSION AS builder

ARG HAS_EXPAT
ARG HAS_PULSEAUDIO

USER root
WORKDIR /build

# Install git and other prereqs
RUN apk add -U --no-cache git make g++ curl libressl2.7-libcrypto \
  pulseaudio pulseaudio-dev pulseaudio-zeroconf pulseaudio-system \
  pulseaudio-utils pulseaudio-libs libvorbis-dev flac-dev alsa-lib \
  alsa-utils avahi-dev bash linux-headers expat-dev 

# Setup build environment
ENV HAS_EXPAT=$HAS_EXPAT HAS_PULSEAUDIO=$HAS_PULSEAUDIO

# build snapserver
RUN cd snapcast/server && make && make installfiles



