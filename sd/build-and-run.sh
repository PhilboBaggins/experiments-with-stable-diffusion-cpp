#!/bin/sh

set -o nounset  # (set -u) No unset variables
set -o errexit  # (set -e) Exit if any statement returns non-true value

DOCKER_TAG="docker-stable-diffusion.cpp"

docker build -t "${DOCKER_TAG}" .

docker run --rm -it \
    --mount type=bind,source="/f/AI/StableDiffusion,target=/models/" \
    --mount type=bind,source="/f/AI/,target=/output/" \
    "${DOCKER_TAG}" \
    -m v1-5-pruned-emaonly-ggml-model-f16.bin \
    -p "hello world"
