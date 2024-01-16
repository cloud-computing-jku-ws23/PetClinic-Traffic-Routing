#!/usr/bin/env bash

pod=$(kubectl get pods -n spring-petclinic -o wide | grep traefik-mesh-controller | awk '{print $1}')
kubectl port-forward pod/$pod -n spring-petclinic 9000:9000

read -p "Press Enter to exit..."