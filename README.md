# Service Mesh (Traffic Routing) - PetClinic
# Table of contents
1. [Students](#Students)
2. [Description](#Description)
3. [Traefik](#Traefik)
4. [Tutorial](#Tutorial)
5. [Key Takeaways & Lessions Learned](#Key-Takeaways-&-Lessions-Learned)

# Students

| Matriculation Number |      Name         |
|:--------------------:|:-----------------:|
|      k12113773       | Christoph Knoll   |
|      k12104719       | Christian Steyrer |
|      k12019969       | Richard Stock     |
|      k11910655       | Alexander Do      |

# Description
Cloud computing Project done during the KV Cloud Computing lecture @ JKU Linz.
Using the Spring PetClinic example and Traefik as a Service Mesh to demonstrate traffic routing in Kubernetes. 

## Project Proposal
The Project Proposal can be found [here](Proposal.md)

## Traefik
![](https://doc.traefik.io/traefik-mesh/assets/images/logo-traefik-mesh-logo.svg)

Traefik Mesh is a lightweight and simpler service mesh designed from the ground up to be straightforward, easy to install and easy to use.

Built on top of Traefik, Traefik Mesh fits as your de-facto service mesh in your Kubernetes cluster supporting the latest Service Mesh Interface specification (SMI).

Moreover, Traefik Mesh is opt-in by default, which means that your existing services are unaffected until you decide to add them to the mesh.

### Service Mesh
A service mesh is a piece of software that adds security, observability, and reliability to the platform level of a microservices application. It is a dedicated layer within the infrastructure that enhances communication.

* Dedicated Infrastructure Layer
* Controls service-to-service communication
* Mostly abstracts communication using a sidecar proxy (control plane).
* Adds security, observability, and reliability

#### Types
Service meshes rely on one of two basic proxy architectures — sidecar or host/node proxies. Let’s discuss the two architectures.

##### With Sidecar Proxy
With the sidecar architecture, a proxy is attached to each application to intercept requests. The proxy injects the features seen earlier into the platform, enabling security, observability, and reliability. This method is invasive, as the deployment objects and network routing rules (using iptables, for example) need to be modified by the service mesh solution.

The advantage of the sidecar architecture, however, is the control. As the proxy lives closer to the application, end-users have more access to in-depth observability metrics and have an easier time automating the flow of traffic. But this advantage comes at a price.

Adding sidecar proxies to each service adds more complexity to your application’s architecture. It becomes more difficult to understand if something has gone wrong or is misconfigured in networking rules. Sidecar proxies also require certain privileges (such as an init container with NET_ADMIN capabilities), and this can lead to security vulnerabilities.

Most service meshes use sidecar proxies, including Istio, Linkerd, and Kuma. These solutions are feature-rich and can become expensive due to the number of proxies required, and operational complexity.
![](https://traefik.io/static/9eb4c7725e3d2a7914c63cc09931432b/1hnkqh_upJEbwpJ7t4fDEB29gsqT3jpkvrrZCBxiKoG4OT-3zesNHA5avMRn-qpTTv8yQqbt4SRUVauM3CyBU9mfgTGwg5RVE1JPeOUb6DKLcKghOnl2x39Hiw91PSbrOMVK9uQr.jpg)



##### With Node Proxy
With the host/node architecture, the proxy is attached to each Kubernetes node instead of each application. Traefik Mesh follows this architecture and uses Traefik Proxy as the reverse proxy. Fewer proxies are required, making the service mesh simpler and less costly to operate.

This type of architecture is non-invasive. Instead of invasively modifying routing tables, the user calls the name of a service and redirects it to the correct node through the DNS. SMI specifications are implemented. The application does not need to be modified. The features stay in the service mesh layer, keeping the applications lightweight while also secure, observable, and reliable.

![](https://traefik.io/static/3b1192ad3763a0f0710e1f28eb822a86/pLQOJZljO1uyM0bGpVnBK6JABLQTVKYIwpK_0LmbJXlSsM55AJBJnFXpkJWtLP-GKj2jawgKKCBBYYvjAFFJGXYx49XUoZud7XKiGhPUSBVl7uunBOlDZQ2ImYaH45xQAI3DXwih.jpg)

## Documentation

### 1. Convert Docker-Compose to Kubernetes File
To convert the docker-compose file to single yaml files for ech microservice we used Kompose.

#### Use [Kompose](https://kompose.io/) to convert docker-compose to kubernetes deployment files. (This step is just for documentation how we set up our enviroment, and shall not done, since deployment files are set up once.)
```bash
kompose convert
```
> Splits docker-compose.yaml into separate deployment files for each microservice. 

Edit deployment files to fit our use case:
* Specify resources, ports, env, etc.
* Remove docker related commands (e.g. dockerize)


### 2. Set up Kubernetes Cluster
After we setup our System to use our Kubernetes we added our deployment settings for our yaml files.

#### Add image pull policy to all deployment .yaml files
```yaml
# ...
    containers:
        - image: springcommunity/spring-petclinic-cloud-visits-service
            name: visits-service
            imagePullPolicy: IfNotPresent
            livenessProbe:
            httpGet:
                port: 8080
                path: /actuator/health/liveness
            # ...
            ports:
            - containerPort: 8080
            resources: {}
        restartPolicy: Always
# ...
```
When the deployment was working we made a shell script which automatically deploy all of the microservices. 

### 3. Traefik Mesh
We need to configure the dns system to use traefik mesh by replace the svc.cluster.local suffix by traefik.mesh.

To access the Traefik mesh api, we need to set up a port forward of the Traefik controller.

#### **`forwardAPI.sh`**
```bash
#!/usr/bin/env bash

pod=$(kubectl get pods -n traefik-mesh -o wide | grep traefik-mesh-controller | awk '{print $1}')
kubectl port-forward pod/$pod -n traefik-mesh 9000:9000

read -p "Press Enter to exit..."
```

The Traefik-API can be reached over the following links:
- localhost:9000/api/configuration/current
- localhost:9000/api/status/nodes
- localhost:9000/api/status/node/{traefik-mesh-pod-name}/configuration
- localhost:9000/api/status/readiness

You can use the following script to determine {traefik-mesh-pod-name}

#### **`proxyConf.sh`**
```bash
proxy=curl http://localhost:9000/api/status/nodes | grep Name | grep -o '"Name":"[^"]*' | awk -F'"' '{print $4}'

echo $proxy

read -p "Press Enter to exit..."
```

## Tutorial

### Prerequesites / Needed dependencies

* Kubernetes Cluster
* Docker
* SSH

#### Install Kind

##### Windows

```bash
winget install --id=kubernetes.kind
```

##### OSX

```bash
brew install kind
```


#### Create Kubernetes Cluster

```bash
kind create cluster
```

### Clone Github
```bash
git clone https://github.com/cloud-computing-jku-ws23/PetClinic-Traffic-Routing.git
```

### Modifies kubeconfig files 
```bash
kubectl config set-context --current --namespace=spring-petclinic
```

### Images of the project 
```docker
springcommunity/spring-petclinic-cloud-api-gateway
springcommunity/spring-petclinic-cloud-customers-service
springcommunity/spring-petclinic-cloud-visits-service
springcommunity/spring-petclinic-cloud-vets-service
```

> **Admin**, **Config**, **Discovery**, **Grafana** and **Prometheus** will be left out because they are optional or not needed.

### Pull needed images from docker hub

#### **`pull.sh:`**
```bash
docker-compose pull
kind load docker-image springcommunity/spring-petclinic-cloud-api-gateway springcommunity/spring-petclinic-cloud-customers-service springcommunity/spring-petclinic-cloud-vets-service springcommunity/spring-petclinic-cloud-visits-service
```

### Change namespace
```bash
kubectl config set-context --current --namespace=spring-petclinic
```

### Deploy to Kubernetes

#### **`deploy.sh:`**
```bash
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
```

### Helm install
```bash
winget install --id=Helm.Helm
```

### Traefik Mesh install
```bash
helm repo add traefik https://traefik.github.io/charts
helm repo update
helm install traefik-mesh traefik/traefik-mesh
```

### How to add annotations to the system
Traefik Mesh has many different annotation possibilities. 
#### Traffic type
Configures which traffic type should be used.
```yaml
mesh.traefik.io/traffic-type: "http"
```

#### Scheme
Configure which custom scheme for request will be used.
```yaml
mesh.traefik.io/scheme: "h2c"
```

#### Retry
Configures how many retry before a network error will be shown.
```yaml
mesh.traefik.io/retry-attempts: "2"
```

#### Circuit breaker
The circuit breaker protects your system from stacking requests to unhealthy services.
```yaml
mesh.traefik.io/circuit-breaker-expression: "Expression"
```

#### Rate Limit
Configures the average and burst request per second. 
```bash
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
More [Details](https://doc.traefik.io/traefik-mesh/configuration/#service-mesh-interface)

## Nice to know

**Delete all deployments** 
```bash 
kubectl delete --all deployments
```
 

## Key Takeaways & Lessions Learned
* Service Mesh enables the control and monitoring of the various parts of an application
* No coding required for features - only yaml configuration
* Kubernetes Cluster in the Cloud
* Kubernetes is a time consuming system
