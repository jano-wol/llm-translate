#!/bin/bash

source ./scripts/resolve_config.sh

find "${LOGS_DIRECTORY}" -type f ! -name ".gitkeep" -delete
find "${MODELS_DIRECTORY}" -type f ! -name ".gitkeep" -delete
