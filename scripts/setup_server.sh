#!/bin/bash

source ./scripts/resolve_config.sh
ORIGINAL_DIR=$(pwd)

cd ./llama.cpp || { echo "Directory not found"; exit 1; }
docker build --build-arg BASE_IMAGE=${BASE_IMAGE} \
             --build-arg LLAMA_CPP_VERSION_TAG=${LLAMA_CPP_VERSION_TAG} \
             --build-arg CONTAINER_PORT=${LLAMA_PORT} \
             --build-arg NUMBER_OF_COMPILE_THREADS=${NUMBER_OF_COMPILE_THREADS} \
             ${USE_GPU_STR:+--build-arg USE_GPU="true"} \
             -t ${IMAGE_NAME} .

cd "$ORIGINAL_DIR"
