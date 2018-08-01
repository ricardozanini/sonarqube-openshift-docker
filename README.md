# SonarQube on OpenShift
This repo contains all of the resources required to build an OpenShift-specific
Docker image of SonarQube.

It is inspired by the upstream SonarQube Docker image:
https://github.com/SonarSource/docker-sonarqube

This repository is a fork of [OpenShiftDemos](https://github.com/OpenShiftDemos/sonarqube-openshift-docker), focusing in a enterprise OpenShift solution. Files here should be used as sample and inside an enterprise environment with access to [Red Hat's repository]().

# Docker Hub

The SonarQube image is available on Docker Hub at: https://hub.docker.com/r/ricardozanini/sonarqube/

# Deploy on OpenShift
You can do use the provided templates with an embedded or postgresql database to deploy SonarQube on 
OpenShift:

SonarQube with Embedded H2 Database:

    oc new-app -f sonarqube-template.yaml --param=SONARQUBE_VERSION=6.7

SonarQube with PostgreSQL Database:

    oc new-app -f sonarqube-postgresql-template.yaml --param=SONARQUBE_VERSION=6.7
