import os
import json
import sys

def create_nvidia_runtime_config(daemon_json_path):
    config = {
        "runtimes": {
            "nvidia": {
                "path": "nvidia-container-runtime",
                "runtimeArgs": []
            }
        }
    }
    with open(daemon_json_path, 'w') as json_file:
        json.dump(config, json_file, indent=2)
    print("Created daemon.json with nvidia runtime.")

def update_daemon_json(daemon_json_path):
    if not os.path.isfile(daemon_json_path):
        create_nvidia_runtime_config(daemon_json_path)
        return True

    with open(daemon_json_path, 'r') as json_file:
        try:
            config = json.load(json_file)
        except json.JSONDecodeError:
            print("daemon.json is not valid, deleting the file.")
            os.remove(daemon_json_path)
            create_nvidia_runtime_config(daemon_json_path)
            return True

    if 'runtimes' in config and 'nvidia' in config['runtimes']:
        print("nvidia runtime already exists in daemon.json. No changes made.")
        return True
    else:
        if 'runtimes' not in config:
            config['runtimes'] = {}

        config['runtimes']['nvidia'] = {
            "path": "nvidia-container-runtime",
            "runtimeArgs": []
        }

        with open(daemon_json_path, 'w') as json_file:
            json.dump(config, json_file, indent=2)
        print("nvidia runtime has been added to daemon.json.")
        return True

if __name__ == "__main__":
    if len(sys.argv) != 2:
        print("Usage: python3 setup_docker_runtime.py <path_to_daemon.json>")
        sys.exit(1)

    daemon_json_path = sys.argv[1]
    success = update_daemon_json(daemon_json_path)
    if not success:
        sys.exit(1)
