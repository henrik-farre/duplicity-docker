FROM alpine:3.6
MAINTAINER henrik@rockhopper.dk
WORKDIR /opt

COPY scripts ./scripts
COPY etc/duplicity/exclude-common /etc/duplicity/exclude-common

RUN set -ex && \
   apk add --update duplicity bash py-paramiko py-packaging py-setuptools && \
   mkdir /backup

ENTRYPOINT ["./scripts/entry"]
CMD ["/usr/bin/duplicity", "--help"]

ARG VCS_REF="local"
LABEL org.label-schema.vcs-ref=$VCS_REF \
      org.label-schema.vcs-url="https://github.com/henrik-farre/duplicity-docker.git" \
      org.label-schema.version="0.7.11-1"
