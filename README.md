# SonarQube on OpenShift
This repo contains all of the resources required to build an OpenShift-specific
Docker image of SonarQube.

It is inspired by the upstream SonarQube Docker image:
https://github.com/SonarSource/docker-sonarqube

This is a fork of [OpenShiftDemos](https://github.com/OpenShiftDemos/sonarqube-openshift-docker), focusing on an enterprise OpenShift solution. The content of this repo should be referenced as a sample and inside an enterprise environment with access to [Red Hat's repository](https://access.redhat.com/containers).

1. Build this image in your environment: `docker build --tag <my-namespace>/sonarqube:7.1 .`
2. Use the appropriate tags following Sonar versions: `docker tag <my-namespace>/sonarqube:7.1 <my-namespace>/sonarqube:latest`
3. Push this image to your corporate registry: `docker push <my-namespace>/sonarqube`
4. Import this image to your OpenShift installation: `oc import-image sonarqube --from=<my-registry>/<my-namespace>/sonarqube --confirm`
5. Run the template (see bellow: Deploy on OpenShift).

If you wish to build the image using a different Sonar version, run:

`docker build --tag <my-namespace>/sonarqube:7.2 --build-arg VERSION=7.2 --rm .`

# Docker Hub

The SonarQube image is available on Docker Hub at: https://hub.docker.com/r/ricardozanini/sonarqube/

# Deploy on OpenShift
You can do use the provided templates with an embedded or postgresql database to deploy SonarQube on 
OpenShift:

SonarQube with Embedded H2 Database:

    oc new-app -f sonarqube-template.yaml --param=SONARQUBE_VERSION=7.1

SonarQube with PostgreSQL Database:

    oc new-app -f sonarqube-postgresql-template.yaml --param=SONARQUBE_VERSION=7.1
