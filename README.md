# Service Mesh (Traffic Routing) - PetClinic
## Description
Cloud computing Project done during the KV Cloud Computing lecture @ JKU Linz.
Using the Spring PetClinic example and Traefik as a Service Mesh to demonstrate traffic routing in Kubernetes. 

## Project Proposal
The Project Proposal can be found [here](Proposal.md)

## How to:

### Pull images and load to Kind (if Kind is used)
For Windows:
```sh
sh pull.sh
```

### Deploy to Kubernetes
For Windows:
```sh
sh deploy.sh
```

### Change namespace
kubectl config set-context --current --namespace=spring-petclinic

### Traefik Mesh install
```sh 
helm repo add traefik https://traefik.github.io/charts
helm repo update
helm install traefik-mesh traefik/traefik-mesh
```
### Add annotations (e.g. rate limits)

```
apiVersion: v1
kind: Service
metadata:
  labels:
    app: customers-service
  name: customers-service
  annotations:
    mesh.traefik.io/ratelimit-average: "10"
    mesh.traefik.io/ratelimit-burst: "10"
spec:
  # ...
status:
  # ...
```

### Live demo with postman
