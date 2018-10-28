FROM alpine:edge
ARG telldus_version=2.1.2
RUN apk --update add --no-cache \
      argp-standalone \
      cmake \
      confuse \
      confuse-dev \
      curl \
      g++ \
      gcc \
      libftdi1 \
      libftdi1-dev \
      make \
      musl-dev
WORKDIR /usr/src/
RUN curl -sL http://download.telldus.com/TellStick/Software/telldus-core/telldus-core-${telldus_version}.tar.gz \
      |tar zx -C /usr/src
RUN ln -s telldus-core-${telldus_version} telldus-core && \
    curl -sL https://github.com/telldus/telldus/commit/687da09e5e09172204a98f5524ce737be196d0f9.patch | patch -p1
WORKDIR /usr/src/telldus-core-${telldus_version}
RUN cmake . && \
    make DESTDIR=/opt all install
