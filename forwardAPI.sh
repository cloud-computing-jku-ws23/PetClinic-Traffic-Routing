#!/usr/bin/env bash

pod=$(kubectl get pods -n traefik-mesh -o wide | grep traefik-mesh-controller | awk '{print $1}')
kubectl port-forward pod/$pod -n traefik-mesh 9000:9000

read -p "Press Enter to exit..."