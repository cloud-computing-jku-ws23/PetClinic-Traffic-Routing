#!/usr/bin/env bash

kubectl apply -f "./k8s/namespace.yaml"     
kubectl apply -f "./k8s/role.yaml"     
kubectl apply -f "./k8s/api-gateway-deployment.yaml"     
kubectl apply -f "./k8s/api-gateway-service.yaml"
kubectl apply -f "./k8s/configmap.yaml"
kubectl apply -f "./k8s/customers-service-deployment.yaml"
kubectl apply -f "./k8s/customers-service-service.yaml"   
kubectl apply -f "./k8s/vets-service-deployment.yaml"  
kubectl apply -f "./k8s/vets-service-service.yaml"     
kubectl apply -f "./k8s/visits-service-deployment.yaml"
kubectl apply -f "./k8s/visits-service-service.yaml"   
