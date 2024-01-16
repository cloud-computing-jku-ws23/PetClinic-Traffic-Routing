import requests
import time
from threading import Thread

# Your service's endpoint
URL = "http://localhost:30036/api/customer/owners"

# Function to send requests
def send_requests(rate, duration):
    start_time = time.time()
    total_requests = rate * duration
    for _ in range(total_requests):
        response = requests.get(URL)  # Or POST, depending on your service
        # Handle response (e.g., print status code)
        print(response.status_code)
        time.sleep(1 / rate)

# Test under normal rate limit
Thread(target=send_requests, args=(100, 10)).start()  # 80 requests per second for 10 seconds

# Test the burst limit
Thread(target=send_requests, args=(100, 1)).start()  # 200 requests in a burst

# Test exceeding the burst limit
Thread(target=send_requests, args=(100, 1)).start()  # 300 requests in a burst to exceed the limit

