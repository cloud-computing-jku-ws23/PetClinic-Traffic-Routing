#!/usr/bin/env bash

# because of company firewall

docker pull traefik/mesh:v1.4.8
docker pull grafana/grafana:6.2.5
docker pull busybox
docker pull jaegertracing/all-in-one:1.18
docker pull prom/prometheus:v2.11.1
docker pull jimmidyson/configmap-reload:v0.2.2
docker pull traefik:v2.5

kind load docker-image traefik/mesh:v1.4.8 grafana/grafana:6.2.5 busybox jaegertracing/all-in-one:1.18 prom/prometheus:v2.11.1 jimmidyson/configmap-reload:v0.2.2 traefik:v2.5

# change deployments of 
# kubectl edit deployment/grafana-core -> imagePullPolicy : IfNotPresent
# kubectl edit deployment/prometheus-core -> imagePullPolicy : IfNotPresent