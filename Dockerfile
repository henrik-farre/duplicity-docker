FROM ubuntu:18.04
WORKDIR /backup
ENV LANG C.UTF-8
COPY scripts ./scripts
COPY etc/duplicity/exclude-common /etc/duplicity/exclude-common

ENTRYPOINT ["./scripts/entry"]
CMD ["/usr/bin/duplicity", "--help"]

RUN set -ex; \
   export DEBIAN_FRONTEND=noninteractive; export DEBIAN_PRIORITY=critical; export DEBCONF_NOWARNINGS=yes; \
   apt-get update \
   && apt-get -y -q --no-install-recommends install software-properties-common \
   && add-apt-repository ppa:duplicity-team/ppa \
   && apt-get update \
   && apt-get -y -q --no-install-recommends install duplicity=0.7.18.1-0ubuntu0ppa1364~ubuntu18.04.1 python-paramiko \
   && apt-get clean -y \
   && apt-get autoremove \
   && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* /var/cache /var/lib/dpkg/info /usr/share/man

ARG VCS_REF="local"
LABEL org.label-schema.vcs-ref=$VCS_REF \
      org.label-schema.vcs-url="https://github.com/henrik-farre/duplicity-docker.git" \
      org.label-schema.version="0.7.18-1" \
      maintainer="Henrik Farre <henrik@rockhopper.dk>"
