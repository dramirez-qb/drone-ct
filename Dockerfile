FROM python:3-alpine
RUN apk --no-cache add curl ca-certificates bash gettext jq
LABEL maintainer "Daniel Ramirez <dxas90@gmail.com>"

ENV DEFAULT_KIND_VERSION=v0.10.0 \
    KUBECTL_VERSION=v1.20.2 \
    DEFAULT_CHART_TESTING_VERSION=v3.3.0\
    CI_DEBUG=false

ENTRYPOINT ["/bin/entrypoint.sh"]
CMD ["--help"]

COPY tools.sh /tmp/tools.sh
COPY entrypoint.sh /bin/entrypoint.sh

RUN /tmp/tools.sh && \
    rm -rf /root/.cache/* /tmp/*
