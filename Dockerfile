FROM ubuntu:xenial
MAINTAINER Alexander Paul <alex.paul@wustl.edu>

LABEL \
  version="1.0.5" \
  description="SURVIVOR image to be used in cwl workflows"

RUN apt-get update && apt-get install -y \
  g++ \
  make \
  gzip \
  wget

ENV SURVIVOR_INSTALL_DIR=/opt/SURVIVOR
ENV SURVIVOR_VERSION=1.0.5

WORKDIR /tmp
RUN wget https://github.com/fritzsedlazeck/SURVIVOR/archive/v$SURVIVOR_VERSION.tar.gz && \
  tar -zxf v$SURVIVOR_VERSION.tar.gz

WORKDIR /tmp/SURVIVOR-$SURVIVOR_VERSION/Debug
RUN make && \
  mkdir --parents $SURVIVOR_INSTALL_DIR && \
  mv ./* $SURVIVOR_INSTALL_DIR

WORKDIR /
RUN ln -s $SURVIVOR_INSTALL_DIR/SURVIVOR /usr/bin/SURVIVOR && \
  rm -rf /tmp/SURVIVOR-$SURVIVOR_VERSION/

COPY survivor_merge_helper.sh /usr/bin/survivor_merge_helper.sh
