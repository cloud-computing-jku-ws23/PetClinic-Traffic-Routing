# Project Proposal - Service Mesh (Traffic Routing)

We will use **[Traefik](https://traefik.io/)** to implement traffic routing using a service mesh between to different deployments.


# Index
1. **[Students](#Students)**
2. **[Definition and Scope of the Project](#Definition-and-Scope)**
3. **[Milestones](#Milestones)**
4. **[Responsibilities](#Responsibilities)**

## Students

| Matriculation Number |      Name         |
|:--------------------:|:-----------------:|
|      k12113773       | Christoph Knoll   |
|      k12104719       | Christian Steyrer |
|      k12019969       | Richard Stock     |
|      k               |                   |

## Definition and Scope
The deployments are based on an open source project **[PetClinic](https://github.com/spring-petclinic/spring-petclinic-microservices)** a sample application consisting of Spring Boot microservices. 

The PetClinic is split into follwoing mandatory artifacts (Grafana and Prometheus *not listed* are optional):

```docker
springcommunity/spring-petclinic-admin-server
springcommunity/spring-petclinic-discovery-server
springcommunity/spring-petclinic-config-server
springcommunity/spring-petclinic-api-gateway
springcommunity/spring-petclinic-customers-service
springcommunity/spring-petclinic-visits-service
springcommunity/spring-petclinic-vets-service
```

The project provides a docker-compose file which needs to be converted into Kubernetes artifacts.

## Milestones
1. [ ] Convert **docker-compose** to **Kubernetes artifacts** (using **[Kompose](https://kompose.io/)**)
2. [ ] Host on **Kubernetes**
3. [ ] **Install Service Mesh** (**[Traefik Mesh](https://traefik.io/traefik-mesh/)**)
4. [ ] **Configure Traefik** to provide **traffic Routing**
5. [ ] Create **reproducible demo** setup and test it
6. [ ] Write **documentation** including **tutorial**
7. [ ] **Presentation**
## Responsibilities
|           Task           |   Assignees    |
|:------------------------:|:--------------:|
|    Initial Deployment    |   Do, Knoll    |
|   Traefik Installation   | Steyrer, Stock |
|  Traefik Configuration   | Steyrer, Stock |
|    Reproducable Demo     |   Do, Knoll    |
| Documentation + Tutorial |      All       |

