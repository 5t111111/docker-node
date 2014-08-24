FROM ubuntu:14.04

MAINTAINER 5t111111 https://github.com/5t111111

RUN apt-get update && apt-get install -y \
        ca-certificates \
        curl

# Receive the required gpg public key to verify the certiificate.
RUN gpg --keyserver pgp.mit.edu --recv-keys 0246406D

ENV NODE_VERSION 0.10.30

RUN curl -SLO "http://nodejs.org/dist/v$NODE_VERSION/node-v$NODE_VERSION-linux-x64.tar.gz" \
        && curl -SLO "http://nodejs.org/dist/v$NODE_VERSION/SHASUMS256.txt.asc" \
        && gpg --verify SHASUMS256.txt.asc \
        && grep " node-v$NODE_VERSION-linux-x64.tar.gz\$" SHASUMS256.txt.asc | sha256sum -c - \
        && tar -xzf "node-v$NODE_VERSION-linux-x64.tar.gz" -C /usr/local --strip-components=1 \
        && rm "node-v$NODE_VERSION-linux-x64.tar.gz" SHASUMS256.txt.asc

CMD ["node"]