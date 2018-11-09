all:	docker-image docker-image-slim

docker-images:	docker-image docker-image-slim

docker-image:
	docker build -t madworx/remoteswinglibrary:latest $(DOCKER_BUILD_OPTS) .

docker-image-slim:
	docker build -t madworx/remoteswinglibrary:slim --build-arg FLAVOUR=slim .

test:	docker-images
	javac test/MinimalSwingApplication.java
	cat Dockerfile Dockerfile.test | docker build -t test -f - .
	rm -rf test/output
	mkdir test/output
	chmod 777 test/output
	mkdir -p test/.vnc
	echo jettehemlik > test/.vnc/passwdfile
	docker run --rm -it -p 5900:5900     \
      -e RESOLUTION=640x480             \
      -v $$(pwd)/test:/home/robot       \
      test .

.PHONY: test docker-image docker-image-slim

