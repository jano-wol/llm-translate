#!/bin/bash

source ./scripts/resolve_config.sh

while ! curl -s --head "http://${SERVER_ADDRESS}:${LLAMA_PORT}/health" | grep -q "200 OK"; do
    echo "Server not ready, waiting for 5 seconds..."
    sleep 5
done

# Run the Python client after the server is ready
python3 ./client/llm_translate_call.py ${SERVER_ADDRESS}:${LLAMA_PORT}
