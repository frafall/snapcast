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

# Either clone or mount Snapcast source volume, make a shell script to do this?
COPY snapcast snapcast
#RUN git clone --recurse-submodules -j4 https://github.com/badaix/snapcast.git
#RUN git clone --recurse-submodules -j4 https://github.com/frafall/snapcast.git
#RUN git clone --recurse-submodules -j4 -branch native_pulseaudio https://github.com/frafall/snapcast.git
#ADD snapcast.tar.gz .

# Setup build environment
ENV HAS_EXPAT=$HAS_EXPAT HAS_PULSEAUDIO=$HAS_PULSEAUDIO

# build snapserver
RUN cd snapcast/server && make && make installfiles

# Now we make a new image for runtime


