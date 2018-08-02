# SonarQube on OpenShift
This repo contains all of the resources required to build an OpenShift-specific
Docker image of SonarQube.

It is inspired by the upstream SonarQube Docker image:
https://github.com/SonarSource/docker-sonarqube

This is a fork of [OpenShiftDemos](https://github.com/OpenShiftDemos/sonarqube-openshift-docker), focusing on an enterprise OpenShift solution. The content of this repo should be referenced as a sample and inside an enterprise environment with access to [Red Hat's repository](https://access.redhat.com/containers).

1. Build this image in your environment: `docker build .`
2. Push this image to your corporate registry: `docker push`
3. Import this image to your OpenShift installation: ``

# Docker Hub

The SonarQube image is available on Docker Hub at: https://hub.docker.com/r/ricardozanini/sonarqube/

# Deploy on OpenShift
You can do use the provided templates with an embedded or postgresql database to deploy SonarQube on 
OpenShift:

SonarQube with Embedded H2 Database:

    oc new-app -f sonarqube-template.yaml --param=SONARQUBE_VERSION=7.1

SonarQube with PostgreSQL Database:

    oc new-app -f sonarqube-postgresql-template.yaml --param=SONARQUBE_VERSION=7.1
