#!/usr/bin/env bash

docker-compose pull
kind load docker-image springcommunity/spring-petclinic-discovery-server springcommunity/spring-petclinic-config-server springcommunity/spring-petclinic-api-gateway springcommunity/spring-petclinic-customers-service springcommunity/spring-petclinic-visits-service springcommunity/spring-petclinic-vets-service