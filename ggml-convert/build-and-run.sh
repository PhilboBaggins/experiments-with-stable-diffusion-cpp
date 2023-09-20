#!/bin/sh

set -o nounset  # (set -u) No unset variables
set -o errexit  # (set -e) Exit if any statement returns non-true value

DOCKER_TAG="ggml-convert"

docker build -t "${DOCKER_TAG}" .

docker run --rm -it \
    --mount type=bind,source="/f/AI/StableDiffusion,target=/models/" \
    "${DOCKER_TAG}" \
    v1-5-pruned-emaonly.ckpt --out_type f16
