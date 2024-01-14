#!/usr/bin/env bash

docker-compose pull
kind load docker-image springcommunity/spring-petclinic-cloud-api-gateway springcommunity/spring-petclinic-cloud-customers-service springcommunity/spring-petclinic-cloud-vets-service springcommunity/spring-petclinic-cloud-visits-service