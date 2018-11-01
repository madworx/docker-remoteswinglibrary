all:	build-docker

build-docker:
	docker build -t madworx/docker-remoteswinglibrary .

test:	build-docker
	javac test/MinimalSwingApplication.java
	rm -rf test/output
	docker run --rm -it -p 5900:5900     \
      -e RESOLUTION=640x480x8           \
      -v $$(pwd)/test:/home/robot       \
      madworx/docker-remoteswinglibrary

.PHONY: test build-docker
