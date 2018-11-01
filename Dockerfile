FROM ubuntu:bionic

MAINTAINER Martin Kjellstrand <martin.kjellstrand@madworx.se>

ARG RSL_REPO="https://github.com/madworx/remoteswinglibrary"
ARG RSL_VERSION="2.2.2mwx3"

ARG APT_MIRROR="ftp.acc.umu.se"
ARG DEPENDENCIES="curl python3-pip python3-setuptools  \
                  python3-wheel openjdk-8-jdk xvfb twm \
                  x11vnc menu scrot"

RUN sed -e "s#archive.ubuntu.com#${APT_MIRROR}#g" \
        -i /etc/apt/sources.list                  \
    && apt-get update -qqy

RUN DEBIAN_FRONTEND=noninteractive apt-get -y -qq          \
                                   --no-install-recommends \
                                   install ${DEPENDENCIES}

RUN cd /usr/local/lib \
    && curl -LsfO "${RSL_REPO}/releases/download/${RSL_VERSION}/remoteswinglibrary-${RSL_VERSION}.jar"

COPY requirements.txt docker-entrypoint.sh /

RUN pip3 install -r requirements.txt \
    && rm requirements.txt

RUN useradd -m robot
USER robot

ENV RESOLUTION="1024x768x16"
ENV PYTHONPATH=

ENTRYPOINT [ "/docker-entrypoint.sh" ]
