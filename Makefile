all:	build-docker

build-docker:
	docker build -t madworx/docker-remoteswinglibrary .

test:	build-docker
	javac test/MinimalSwingApplication.java
	cat Dockerfile Dockerfile.test | docker build -t test -f - .
	rm -rf test/output
	mkdir -p test/.vnc
	echo jettehemlik > test/.vnc/passwdfile
	docker run --rm -it -p 5900:5900     \
      -e RESOLUTION=640x480x16          \
      -v $$(pwd)/test:/home/robot       \
      test

.PHONY: test build-docker
