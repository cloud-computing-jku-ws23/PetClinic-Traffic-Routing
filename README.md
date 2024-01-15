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

### Deploy to Kubernates
For Windows:
```sh
sh deploy.sh
```

### Change namespace
kubectl config set-context --current --namespace=spring-petclinic
