FROM  alpine:latest
RUN   adduser -S -D -H -h /xmrig miner
RUN   apk --no-cache upgrade && \
      apk --no-cache add \
        git \
        cmake \
        libuv-dev \
        build-base && \
      git clone https://github.com/xmrig/xmrig

ADD   set0.patch /xmrig

RUN      cd /xmrig && \
      patch -p1 <set0.patch && \
      cmake -DWITH_HTTPD=OFF . && \
      make -j && \
      apk del \
        build-base \
        cmake \
        git
USER miner
WORKDIR    /xmrig
ENTRYPOINT  ["./xmrig"]
