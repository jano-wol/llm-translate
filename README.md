# llm_translate
This repository demonstrates how to set up a [llama.cpp](https://github.com/ggerganov/llama.cpp) server and call it using a Python client for translation purposes. The goal of this repository is to provide a minimal working example of a ``llama.cpp`` server/client pair.

## Setup
These instructions assume the server's host machine runs a Debian-based system, such as Ubuntu.
The setup will require some trust from the repository owner, especially when using Nvidia GPUs, as some custom bash scripts need to run with `sudo` privileges. This ensures a convenient and quick setup.

### Configuration
Before starting the setup, review the configuration file [config.conf](./config.conf). This file contains default values optimized for a quick test of the `llama.cpp` server's capabilities. For more advanced use, such as deploying a larger model, you can easily modify the configuration.

One key setting is `USE_GPU`. Set this to `true` if you have Nvidia GPUs available and wish to take advantage of their capabilities. 

### Disk Space Requirements
- **Default Setup** (without GPU): The setup will require approximately **5.5 GB** of disk space.
- **With GPU Support** (`USE_GPU=true`): An additional **10 GB** will be required, bringing the total to around **15.5 GB**.

### Host setup
#### ``docker`` install
Run the following command to check if ``docker`` is installed:
```sh
docker --version
```
If the version number is not responded call:
```sh
sudo apt install docker-ce
```
and
```sh
sudo systemctl start docker
```

#### ``nvidia-container-toolkit`` install (only if using Nvidia GPUs)
This step is only required if you plan to use Nvidia GPUs (``USE_GPU=true``).


Run the following command to check if ``nvidia-container-toolkit`` is installed:
```sh
nvidia-container-toolkit --version
```
If the version number is not responded call the following script from the root of the repository:
```sh
sudo ./scripts/setup_nvidia_container_toolkit.sh
```

#### ``nvidia`` docker runtime install (only if using Nvidia GPUs)
This step is only required if you plan to use Nvidia GPUs (``USE_GPU=true``).


If the command
```sh
sudo docker info | grep Runtimes
```
doesn't show ``nvidia`` as a runtime, you need to add it. Run the following script from the root of the repository:
```sh
sudo ./scripts/setup_nvidia_docker_runtime.sh
```

#### Getting the model file 
You have two options to get a model file.

1. Download a model file: You can download the model from Hugging Face. To do this, execute the following script:
```sh
sudo ./scripts/download_model.sh
```
This script utilizes the configuration variables `HUGGING_FACE_MODEL_REPO` and `MODEL_FILE` of [config.conf](./config.conf).

2. Use your own model file: Place your model file in the `./models` folder. Ensure that the model file name matches the `MODEL_FILE` variable in [config.conf](./config.conf).

### Server setup
To setup the server, run:
```sh
sudo ./scripts/setup_server.sh
```

## Controlling the server 
Start the server:
```sh
sudo ./scripts/start_server.sh
```
Stop the server:
```sh
sudo ./scripts/stop_server.sh
```
You can check if the server is running locally on your machine:
```sh
sudo ./scripts/is_server_running_locally.sh
```
During the startup process, it is possible that the script may return false for a few seconds; however, everything is still okay. If you suspect there are errors during the server startup, check the log files in the `./logs` folder.

## Client call
Once the server is running, you can try it out by giving it some tasks with a client call:
```sh
sudo ./scripts/translate.sh
```

## Cleanup
To cleanup your environment, run the following command:
```sh
sudo ./scripts/cleanup/cleanup.sh
```
This will remove the installed components of the repository i.e. the log and model files and the Docker related volumes.

