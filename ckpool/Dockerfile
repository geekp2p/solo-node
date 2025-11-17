# syntax=docker/dockerfile:1

FROM debian:bookworm-slim AS builder

RUN apt-get update \
    && apt-get install -y --no-install-recommends \
       ca-certificates \
       build-essential \
       autoconf \
       automake \
       libtool \
       pkg-config \
       libevent-dev \
       libjansson-dev \
       libssl-dev \
       libcurl4-openssl-dev \
       uthash-dev \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /src
COPY src/ /src
RUN if [ ! -f /src/autogen.sh ]; then \
        echo "ckpool sources are missing. Run ./ckpool/fetch-source.sh before building." >&2; \
        exit 1; \
    fi && \
    rm -f /src/.gitkeep && rm -rf /src/.git
# Ensure autotools files are ready for Debian bookworm's libtool
RUN mkdir -p m4 \
    && find . -type f \( -name 'autogen.sh' -o -name 'configure.ac' -o -name 'Makefile.am' \) -exec sed -i 's/\r$//' {} + \
    && find . -name 'Makefile.am' -exec sed -i '/^[[:space:]]*ACLOCAL_AMFLAGS/d' {} + \
    && chmod +x autogen.sh \
    && ./autogen.sh \
    && ./configure \
    && make -j"$(nproc)"

FROM debian:bookworm-slim

RUN apt-get update \
    && apt-get install -y --no-install-recommends \
       ca-certificates \
       libevent-2.1-7 \
       libjansson4 \
       libssl3 \
       libcurl4 \
    && rm -rf /var/lib/apt/lists/*

COPY --from=builder /src/ckpool /usr/local/bin/ckpool

ENTRYPOINT ["ckpool"]
CMD ["-h"]