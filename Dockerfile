#FROM alpine:3.6
FROM frolvlad/alpine-glibc:alpine-3.6

RUN apk update \
 && apk add ca-certificates wget \
 && update-ca-certificates

RUN apk add --update-cache openjdk8

RUN echo 'Download Intellij IDE'\
 && wget -nv https://download.jetbrains.com/idea/ideaIC-2017.1.3.tar.gz -O /tmp/intellij.tar.gz \
 && mkdir -p /opt/intellij \
 && tar -xzf /tmp/intellij.tar.gz --strip-components=1 -C /opt/intellij \
 && rm /tmp/intellij.tar.gz

#CMD /usr/local/bin/intellij
CMD /opt/intellij/bin/idea.sh
