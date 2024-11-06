import requests

# Text completion example
response = requests.post(
    "http://ip-26-0-161-153:8000/v1/completions",
    json={
        "model": "Qwen/Qwen2-VL-72B-Instruct",
        "prompt": "What is the capital of France?",
        "max_tokens": 100,
        "temperature": 0.7
    }
)
print(response.json())



# For video input (Qwen2-VL supports this)
response = requests.post(
    "http://localhost:8000/v1/chat/completions",
    json={
        "model": "Qwen/Qwen2-VL-72B-Instruct",
        "messages" : [
        {
        "role": "user",
        "content": [
            {
                "type": "video",
                "video": "/fsx/miquel/hf-cinepile-collab2/hf-cinepile-collab/eval_cinepile/qwen-2-vl/test.mp4",
                "max_pixels": 360 * 420,
                "fps": 1.0,
            },
            {"type": "text", "text": "Describe this video."},
        ],
        }
]
    }
)
print(response.json())