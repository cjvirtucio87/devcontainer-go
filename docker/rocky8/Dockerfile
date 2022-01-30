# syntax=docker/dockerfile:1.3-labs
FROM rockylinux/rockylinux:8

USER 0

ENV USR_LOCAL_GO=/usr/local/go \
    REMOTE_USER=dev \
    REMOTE_USER_HOME=/home/dev

ENV PATH="${USR_LOCAL_GO}/bin:${PATH}"

ARG REMOTE_UID=1000
ARG REMOTE_GID=1000

RUN <<'EOF'
set -e

dnf -y update
dnf -y group install development

mkdir --parents "${USR_LOCAL_GO}"
curl \
  --location \
  https://go.dev/dl/go1.17.6.linux-amd64.tar.gz \
  | tar \
      --extract \
      --gunzip \
      --strip-components 1 \
      --directory "${USR_LOCAL_GO}"

chgrp --recursive "${REMOTE_GID}" "${USR_LOCAL_GO}"
chmod --recursive g=u "${USR_LOCAL_GO}"

groupadd --gid "${REMOTE_GID}" "${REMOTE_USER}"
useradd --uid "${REMOTE_UID}" --gid "${REMOTE_GID}" --home-dir "${REMOTE_USER_HOME}" "${REMOTE_USER}"

go version
EOF

COPY docker/rocky8/contrib /

RUN <<'EOF'
chgrp "${REMOTE_GID}" /docker-entrypoint.sh
chmod g=u /docker-entrypoint.sh
EOF

USER "${REMOTE_USER}"

WORKDIR "${HOME}"

ENTRYPOINT ["/docker-entrypoint.sh"]
