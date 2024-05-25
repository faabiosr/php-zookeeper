FROM ubuntu:20.04 AS base

ENV TZ=America/Sao_Paulo

RUN export DEBIAN_FRONTEND="noninteractive" \
    && ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone \
    && apt-get -yqq update \
    && apt-get -yqq install \
      ant \
      autoconf \
      cmake \
      default-jdk \
      libcppunit-dev \
      libtool \
      maven \
      pkg-config \
      tzdata \
      wget \
    && apt-get -yqq autoremove --purge \
    && rm -rf /root/.cache \
    && echo "done"

COPY scripts scripts

ARG ZK_VERSION=3.7.2

RUN ./scripts/zk-server-install.sh $ZK_VERSION
