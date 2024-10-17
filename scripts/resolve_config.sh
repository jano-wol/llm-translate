#!/bin/bash

if [ -f "./config.conf" ]; then
    while IFS='=' read -r key value; do
        value=$(echo "$value" | cut -d'#' -f1 | xargs)
        key=$(echo "$key" | xargs)

        if [[ ! $key =~ ^# ]] && [[ -n $key ]]; then
            export "$key"="$value"
        fi
    done < ./config.conf
else
    echo "Configuration file not found!"
    exit 1
fi

if [ ${USE_GPU} = true ]; then
    HARDWARE_STRING="gpu"
    BASE_IMAGE=nvidia/cuda:12.1.1-cudnn8-runtime-ubuntu22.04
    USE_GPU_STR="true"
else
    HARDWARE_STRING="cpu"
    BASE_IMAGE=ubuntu:22.04
    USE_GPU_STR=""
fi

timestamp() {
    date +"%Y%m%d%H%M%S"
}

LOGS_DIRECTORY="./logs"
MODELS_DIRECTORY="./models"
PROJECT_NAME="llm_translate"
SERVER_NAME="${PROJECT_NAME}_llama_server_${HARDWARE_STRING}"
IMAGE_NAME="${SERVER_NAME}_image"
CONTAINER_NAME="${SERVER_NAME}_container_$(timestamp)"

