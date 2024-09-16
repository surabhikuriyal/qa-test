# qa-test

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
