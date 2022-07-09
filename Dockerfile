FROM alpine:edge as build

RUN apk --no-cache && \
  apk --no-cache add \
  bash \
  curl \
  ca-certificates \
  git \
  tmux \
  util-linux \
  pciutils \
  usbutils \
  coreutils \
  binutils \
  findutils \
  grep \
  iproute2 && \
  ln -sf /bin/bash /bin/sh

COPY ./config/resurrect/ /root/.cache/resurrect/
COPY ./config/tmux.conf /root/.tmux.conf
COPY ./config/bashrc /root/.bashrc
COPY ./bin/. /usr/local/bin/

RUN /usr/local/bin/tmux-plugins

FROM scratch

ARG BUILD_DATE="$(date +'%Y-%m-%d %H:%M')"

LABEL \
  org.label-schema.name="tmux" \
  org.label-schema.description="simple container for bash/tmux" \
  org.label-schema.url="https://hub.docker.com/r/casjaysdevdocker/bash" \
  org.label-schema.vcs-url="https://github.com/casjaysdevdocker/bash" \
  org.label-schema.build-date=$BUILD_DATE \
  org.label-schema.version=$BUILD_DATE \
  org.label-schema.vcs-ref=$BUILD_DATE \
  org.label-schema.license="WTFPL" \
  org.label-schema.vcs-type="Git" \
  org.label-schema.schema-version="latest" \
  org.label-schema.vendor="CasjaysDev" \
  maintainer="CasjaysDev <docker-admin@casjaysdev.com>"

ENV VIM_INDENT="2" \
  SHELL="/bin/bash" \
  TERM="xterm-256color" \
  HOSTNAME="casjaysdev-vim" \
  TZ="${TZ:-America/New_York}"

WORKDIR /root
VOLUME ["/root","/config"]

COPY --from=build /. /

HEALTHCHECK CMD [ "/usr/local/bin/entrypoint-bash.sh", "healthcheck" ]
ENTRYPOINT [ "/usr/local/bin/entrypoint-bash.sh" ]
CMD [ "/usr/bin/tmux" ]
