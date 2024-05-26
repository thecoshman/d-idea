FROM alpine:latest as builder

ARG INTELLIJ_VERSION

RUN apk add --no-cache \
  wget

RUN wget --progress=dot:giga "https://download.jetbrains.com/idea/ideaIC-${INTELLIJ_VERSION}.tar.gz" -O /tmp/intellij.tar.gz

RUN mkdir -p /tmp/intellij

RUN tar -xzf /tmp/intellij.tar.gz --strip-components=1 -C /tmp/intellij

FROM alpine:latest

MAINTAINER thecoshman "d-idea@thecoshman.com"

COPY --from=builder /tmp/intellij /opt/intellij

RUN apk add --no-cache \
  e2fsprogs \
  fontconfig \
  gcompat \
  git \
  msttcorefonts-installer \
  nss \
  openjdk21

RUN apk upgrade --no-cache --update-cache

RUN update-ms-fonts

RUN fc-cache -f

ENV HOME=/home

CMD /opt/intellij/bin/idea.sh