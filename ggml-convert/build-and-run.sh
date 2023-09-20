#!/bin/sh

set -o nounset  # (set -u) No unset variables
set -o errexit  # (set -e) Exit if any statement returns non-true value

if [ $# -eq 3 ]; then
    MODEL_DIRECTORY="$1"
    MODEL_FILE="$2"
    OUTPUT_TYPE="$3"
elif [ $# -eq 2 ]; then
    MODEL_DIRECTORY="$1"
    MODEL_FILE="$2"
    OUTPUT_TYPE="f16"
else
    echo "Usage: $0 MODEL_DIRECTORY MODEL_FILE [OUTPUT_TYPE]" >&2
    exit 1
fi

DOCKER_TAG="ggml-convert"

cd "$(dirname -- "$0")"

docker build -t "${DOCKER_TAG}" .

docker run --rm -it \
    --mount type=bind,source="${MODEL_DIRECTORY},target=/models/" \
    "${DOCKER_TAG}" \
    "${MODEL_FILE}" \
    --out_type "${OUTPUT_TYPE}"
