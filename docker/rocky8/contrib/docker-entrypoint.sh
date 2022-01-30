#!/usr/bin/env bash

set -e

function main {
  >&2 printf "running as [%d:%d]\n" "$(id --user)" "$(id --group)"

  if [[ -v AD_HOC ]]; then
    >&2 echo "ad-hoc mode; dropping into shell"
    exec /bin/bash
  else
    >&2 echo "devcontainer mode; sleeping perpetually"
    sleep infinity
  fi
}

main "$@"
