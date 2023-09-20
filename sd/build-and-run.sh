#!/bin/sh

set -o nounset  # (set -u) No unset variables
set -o errexit  # (set -e) Exit if any statement returns non-true value


if [ $# -eq 4 ]; then
    MODEL_DIRECTORY="$1"
    MODEL_FILE="$2"
    OUTPUT_DIRECTORY="$3"
    PROMPT="$4"
else
    echo "Usage: $0 MODEL_DIRECTORY MODEL_FILE OUTPUT_DIRECTORY PROMPT" >&2
    exit 1
fi

DOCKER_TAG="docker-stable-diffusion.cpp"

cd "$(dirname -- "$0")"

docker build -t "${DOCKER_TAG}" .

docker run --rm -it \
    --mount type=bind,source="${MODEL_DIRECTORY},target=/models/" \
    --mount type=bind,source="${OUTPUT_DIRECTORY},target=/output/" \
    "${DOCKER_TAG}" \
    -m "${MODEL_FILE}" \
    -p "${PROMPT}"
