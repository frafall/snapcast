.PHONY: client server

ALPINE=3.9
IMAGE=frafall/snapcast-builder:$(ALPINE)

ARGS=--build-arg VERSION=$(ALPINE) \
     --build-arg HAS_EXPAT=1 \
     --build-arg HAS_PULSEAUDIO=1 \
     --build-arg PUID=`id --user`

all: 	client server

server:
	$(MAKE) -C server

client:
	$(MAKE) -C client
	
clean:
	$(MAKE) clean -C client 
	$(MAKE) clean -C server 
	rm -f *~
	
installclient:
	$(MAKE) install -C client 

installserver:
	$(MAKE) install -C server 

uninstallclient:
	$(MAKE) uninstall -C client 

uninstallserver:
	$(MAKE) uninstall -C server 
	
alpine-builder:
	docker build -f Dockerfile.build $(ARGS) -t $(IMAGE) .

compile-alpine:
	if [ ! -z `docker inspect --type=image $(IMAGE)` ]; then \
		$(MAKE) alpine-builder; \
	fi
	docker run -it --rm -v `pwd`:/build/snapcast $(IMAGE) \
	  /bin/bash -c  "(cd /build/snapcast/server && make)"

