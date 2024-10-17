import logging
import requests
import sys


def get_url(address):
    return f"http://{address}/v1/chat/completions"


def get_request(input_str):
    request = {
        "messages": [
            {
                "role": "system",
                "content": "You are a helpful AI assistant"
            },
            {
                "role": "user",
                "content": input_str
            }
        ]
    }
    return request


def get_task():
    task_path = './client/task.txt'
    try:
        with open(task_path, 'r', encoding='utf-8') as task:
            for line in task:
                return line.strip()
    except FileNotFoundError:
        print(f'The file {task_path} was not found.')
    except Exception as e:
        print(f'An error occurred: {e}')


def get_sentences():
    sentences_path = './client/sentences.txt'
    ret = []
    try:
        with open(sentences_path, 'r', encoding='utf-8') as sentences:
            for sentence in sentences:
                ret.append(sentence.strip())
    except FileNotFoundError:
        print(f'The file {sentences_path} was not found.')
    except Exception as e:
        print(f"An error occurred: {e}")
    return ret


def main():
    task = get_task()
    sentences = get_sentences()
    url = get_url(sys.argv[1].strip())
    logging.basicConfig(level="INFO", format='%(asctime)s - %(levelname)s - %(message)s')
    processed = 0
    for sentence in sentences:
        req = get_request(f"{task} {sentence}")
        response = requests.post(url, json=req)
        response_json = response.json()
        translation = response_json["choices"][0]["message"]["content"]
        processed += 1
        logging.info(f"{processed:>3}/{len(sentences)} {sentence} -> {translation}")


if __name__ == "__main__":
    main()
