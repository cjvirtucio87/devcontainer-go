#!/usr/bin/env bash

set -e

### Build images for this project.
###
### Usage:
###   <Options> ./build.sh <Arguments>

if (return 0 2>/dev/null); then
  if [[ -v _BUILD_SOURCED_ ]]; then
    >&2 echo "build.sh already sourced"
    return
  fi

  _BUILD_SOURCED_=1
fi

BUILD_ROOT_DIR="$(dirname "$(readlink --canonicalize "$0")")"
readonly BUILD_ROOT_DIR
readonly ROCKY8_TAG="cjvirtucio87/go-devc:rocky8"
readonly LATEST_TAG="cjvirtucio87/go-devc:latest"

function docker_build {
  local filepath=$1
  local tag=$2

  docker build \
    --tag "${tag}" \
    --file "${filepath}" \
    "${BUILD_ROOT_DIR}"
}

function docker_build_rocky8 {
  >&2 echo "building rocky8 image"
  docker_build "${BUILD_ROOT_DIR}/docker/rocky8/Dockerfile" "${ROCKY8_TAG}"
}

function tag_latest {
  >&2 echo "taggin $1 as the latest"
  docker tag "$1" "${LATEST_TAG}"
}

function main {
  docker_build_rocky8
  tag_latest "${ROCKY8_TAG}"
}

(return 0 2>/dev/null) || main "$@"
