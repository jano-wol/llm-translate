ARG BASE_IMAGE=ubuntu:22.04

FROM ${BASE_IMAGE}

ARG LLAMA_CPP_VERSION_TAG
ARG CONTAINER_PORT
ARG NUMBER_OF_COMPILE_THREADS
ARG USE_GPU

ENV DEBIAN_FRONTEND=noninteractive
ENV TZ=America/New_York

RUN apt-get update && apt-get install -y \
    build-essential \
    cmake \
    git \
    curl \
    ${USE_GPU:+nvidia-cuda-toolkit}

WORKDIR /app

RUN git clone --depth 1 --branch ${LLAMA_CPP_VERSION_TAG} https://github.com/ggerganov/llama.cpp.git

WORKDIR /app/llama.cpp/

RUN cmake -B build ${USE_GPU:+-DGGML_CUDA=ON} && cmake --build build --config Release -j ${NUMBER_OF_COMPILE_THREADS}

EXPOSE ${CONTAINER_PORT}

# Command to run when the container starts. Host has to be 0.0.0.0 in the container 
CMD ["sh", "-c", "./build/bin/llama-server \
    -m ${MODEL_PATH} \
    -ngl ${NGL} \
    --temp ${TEMP} \
    --timeout ${TIMEOUT} \
    --n_predict ${N_PREDICT} \
    --port ${RUNTIME_PORT} \
    --host 0.0.0.0 \
    --log-file /var/log/llama/${LOG_FILE} \
    --metrics"]

