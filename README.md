# Employee Service

## Overview
This service handles file generation.

## Setup with docker
To run this project, install it locally using npm:

```bash
npm install
npm start

docker build -t employee-service .
docker run -p 8080:8080 --name employee-service employee-service

# if to local registry
docker build -t localhost:5000/employee-service:latest .
docker run -p 8080:8080 localhost:5000/employee-service:latest
```
Test the api 
```bash
curl http://localhost:8080/api/health
```
```bash
response { "message": "Hello from the API!" }
```
check the logs also