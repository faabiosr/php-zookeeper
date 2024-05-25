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
      software-properties-common \
      tzdata \
      wget \
    && apt-get -yqq autoremove --purge \
    && rm -rf /root/.cache \
    && echo "done"

ARG PHP_VERSION=7.4

RUN export DEBIAN_FRONTEND="noninteractive" \
    && add-apt-repository -y ppa:ondrej/php \
    && apt-get -yqq update \
    && apt-get -yqq install \
      php${PHP_VERSION}-cli \
      php${PHP_VERSION}-dev \
      php${PHP_VERSION}-xml \
    && apt-get -yqq autoremove --purge \
    && rm -rf /root/.cache \
    && echo "done"

COPY scripts scripts

ARG ZK_VERSION=3.7.2

RUN ./scripts/zk-client-install.sh ${ZK_VERSION} \
  && ./scripts/zk-server-install.sh ${ZK_VERSION}
