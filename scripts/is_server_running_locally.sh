#!/bin/bash

source ./scripts/resolve_config.sh
is_server_running_locally() {
    curl -s --head http://[0000:0000:0000:0000:0000:0000:0000:0001]:${LLAMA_PORT}/health | grep "200 OK" > /dev/null
}

# Check if the server is running locally and print the result
if is_server_running_locally; then
    echo "Server is running on this machine."
    exit 0
else
    echo "Server is NOT running on this machine."
    exit 1
fi

