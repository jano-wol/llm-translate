#!/bin/bash

source ./scripts/resolve_config.sh
docker run -d --rm \
    --name ${CONTAINER_NAME} \
    ${USE_GPU_STR:+--runtime=nvidia} \
    -p ${LLAMA_PORT}:${LLAMA_PORT} \
    -v ${MODELS_DIRECTORY}/${MODEL_FILE}:/app/llama.cpp/models/${MODEL_FILE} \
    -v ${LOGS_DIRECTORY}:/var/log/llama \
    -e MODEL_PATH=${MODELS_DIRECTORY}/${MODEL_FILE} \
    -e NGL=${NGL} \
    -e TEMP=${TEMP} \
    -e TIMEOUT=${TIMEOUT} \
    -e N_PREDICT=${N_PREDICT} \
    -e RUNTIME_PORT=${LLAMA_PORT} \
    -e LOG_FILE=${CONTAINER_NAME}.log \
    ${IMAGE_NAME}

