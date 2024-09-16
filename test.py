import requests
import time

def test_frontend_backend():
    while True:
        try:
            response = requests.get('http://backend-service:3000/greet')
            if response.status_code == 200:
                return response.text
            else:
                raise Exception(f"Backend returned unexpected status code: {response.status_code}")
        except requests.exceptions.RequestException as e:
            print(f"Error connecting to backend service: {e}")
            time.sleep(5)
        else:
            break

if __name__ == "__main__":
    greeting_message = test_frontend_backend()
    print(f"Greeting message received: {greeting_message}")
