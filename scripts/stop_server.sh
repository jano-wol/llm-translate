#!/bin/bash

source ./scripts/resolve_config.sh
docker ps -a --filter "name=${PROJECT_NAME}" -q | xargs -r docker stop

