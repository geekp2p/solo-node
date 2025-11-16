# syntax=docker/dockerfile:1

FROM debian:bookworm-slim AS builder

RUN apt-get update \
    && apt-get install -y --no-install-recommends \
       ca-certificates \
       git \
       build-essential \
       autoconf \
       automake \
       libtool \
       pkg-config \
       libevent-dev \
       libjansson-dev \
       libssl-dev \
       uthash-dev \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /src
RUN git clone --depth=1 https://github.com/ckolivas/ckpool.git .
RUN ./autogen.sh \
    && ./configure \
    && make -j"$(nproc)"

FROM debian:bookworm-slim

RUN apt-get update \
    && apt-get install -y --no-install-recommends \
       ca-certificates \
       libevent-2.1-7 \
       libjansson4 \
       libssl3 \
    && rm -rf /var/lib/apt/lists/*

COPY --from=builder /src/ckpool /usr/local/bin/ckpool

ENTRYPOINT ["ckpool"]
CMD ["-h"]