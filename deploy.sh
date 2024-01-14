#!/usr/bin/env bash
kubectl apply -f "./deployments/api-gateway-deployment.yaml"
kubectl apply -f "./deployments/config-server-deployment.yaml"
kubectl apply -f "./deployments/customers-service-deployment.yaml"
kubectl apply -f "./deployments/discovery-server-deployment.yaml"
kubectl apply -f "./deployments/vets-service-deployment.yaml"
kubectl apply -f "./deployments/visits-service-deployment.yaml"