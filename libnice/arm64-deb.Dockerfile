FROM arm64v8/debian as builder

ARG LIBWEBSOCKETS_VERSION=v3.2-stable
ARG LIBWEBSOCKETS_REPO=https://github.com/warmcat/libwebsockets.git

ARG LIBNICE_VERSION=0.1.18
ARG LIBNICE_REPO=https://github.com/libnice/libnice.git

ARG USRSCTP_REPO_VERSION=0.9.5.0
ARG USRSCTP_REPO=https://github.com/sctplab/usrsctp.git

ARG LIBSRTP_VERSION=2.2.0
ARG LIBSRTP_REPO=https://github.com/cisco/libsrtp/archive/v${LIBSRTP_VERSION}.tar.gz

ARG JANUS_VERSION=v0.11.6
ARG JANUS_REPO=https://github.com/meetecho/janus-gateway.git

RUN mkdir /workspace

# install build dependencies
RUN apt-get update && apt-get install -y \
    automake \
    build-essential \
    cmake \
    cmake-data \
    ninja-build \
    pkg-config \
    python3 \
    python3-dev \
    python3-pip \
    ruby-full

# install rabbitmq dependencies
# install mqtt dependencies
# install nanomsg dependencies
# install libwebsockets dependencies

# build libnice
WORKDIR /workspace
RUN python3 -m pip install --upgrade pip setuptools wheel
RUN python3 -m venv venv
RUN venv/bin/python -m pip install meson
RUN git clone ${LIBNICE_REPO} --branch ${LIBNICE_VERSION} .
RUN source venv/bin/activate && meson --prefix=/usr/local build
RUN source venv/bin/activate && ninja -C build
RUN source venv/bin/activate && ninja -C build

