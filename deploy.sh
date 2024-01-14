#!/usr/bin/env bash
kubectl apply -f "./deployments/config-server-deployment.yaml"
kubectl apply -f "./deployments/discovery-server-deployment.yaml"
kubectl apply -f "./deployments/api-gateway-deployment.yaml"
kubectl apply -f "./deployments/customers-service-deployment.yaml"
kubectl apply -f "./deployments/vets-service-deployment.yaml"
kubectl apply -f "./deployments/visits-service-deployment.yaml"

kubectl apply -f "./services/config-server-service.yaml"
kubectl apply -f "./services/discovery-server-service.yaml"
kubectl apply -f "./services/api-gateway-service.yaml"
kubectl apply -f "./services/customers-service-service.yaml"
kubectl apply -f "./services/vets-service-service.yaml"
kubectl apply -f "./services/visits-service-service.yaml"