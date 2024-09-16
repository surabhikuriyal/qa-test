# qa-test

 ---------------------------------------------------------------------------------------------------------------------------------------------------------------
# test.py

This project demonstrates a simple frontend-backend communication setup deployed on Kubernetes. It consists of two services:
- Frontend Service: A Node.js application that displays a greeting message fetched from the backend.
- Backend Service: A Python Flask application that provides the greeting message.

The project aims to showcase integration testing between microservices running in a Kubernetes environment.

**Setup Instructions**:

1. Install Minikube or Kind for local Kubernetes cluster setup.
2. Clone this repository to your local machine.
3. Apply the Kubernetes deployments using kubectl:
kubectl apply -f frontend-deployment.yaml kubectl apply -f backend-deployment.yaml

**Running Automated Tests**:

To run the automated tests, follow these steps:
1. Ensure the Kubernetes deployments are running.
2. Run the Python test script:
 python test_integration.py


This script will attempt to connect to the backend service and retrieve the greeting message.


---------------------------------------------------------------------------------------------------------------------------------------------------------------

# system_health_monitoring_script.sh

Script that monitors the health of a Linux system. It should check CPU usage, memory usage, disk space, and running processes. 
If any of these metrics exceed predefined thresholds (e.g., CPU usage > 80%), the script should send an alert to the console or a log file.


---------------------------------------------------------------------------------------------------------------------------------------------------------------

# application_health_checker.sh

Script that can check the uptime of an application and determine if it is functioning correctly or not. 
The script accurately assess the application's status by checking HTTP status codes. It should be able to detect if the application is 'up', meaning it is functioning correctly, 
or 'down', indicating that it is unavailable or not responding.
