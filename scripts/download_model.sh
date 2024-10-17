#!/bin/bash

source ./scripts/resolve_config.sh
MODEL_FILE_PATH="${MODELS_DIRECTORY}/${MODEL_FILE}"

if [ -f ${MODEL_FILE_PATH} ]; then
    echo "Model file already exists. Skipping download."
else
    echo "Downloading model file..."
    URL="https://huggingface.co/${HUGGING_FACE_MODEL_REPO}/resolve/main/${MODEL_FILE}"
    curl -L -o ${MODEL_FILE_PATH} ${URL}
    sudo chown -R "$SUDO_USER":"$SUDO_USER" "${MODEL_FILE_PATH}"
fi
