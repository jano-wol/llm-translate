#!/bin/bash

source ./scripts/resolve_config.sh

# Stop and remove containers
echo "Stopping and removing containers with prefix '${PROJECT_NAME}'..."
docker ps -a --filter "name=${PROJECT_NAME}" -q | xargs -r docker stop
docker ps -a --filter "name=${PROJECT_NAME}" -q | xargs -r docker rm

# Remove images
echo "Removing images with prefix '${PROJECT_NAME}'..."
docker images --filter "reference=${PROJECT_NAME}*" -q | xargs -r docker rmi -f

# Remove unused volumes
echo "Removing volumes with prefix '${PROJECT_NAME}'..."
docker volume ls --filter "name=${PROJECT_NAME}" -q | xargs -r docker volume rm

# Clear the build cache
echo "Clearing the Docker build cache..."
docker builder prune -f

echo "Show Docker disk usage summary..."
sudo docker system df
