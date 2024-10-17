#!/bin/bash

# Define the path to the daemon.json file
DAEMON_JSON_PATH="/etc/docker/daemon.json"

python3 ./scripts/setup_docker_runtime.py "$DAEMON_JSON_PATH"

# Check if the Python script executed successfully
if [ ! $? -eq 0 ]; then
    echo "Failed to update daemon.json."
    exit 1
fi

# Restart Docker to apply the changes
sudo systemctl restart docker
echo "Docker has been restarted."
