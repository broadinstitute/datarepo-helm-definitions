#!/bin/bash

helm namespace upgrade dd-secrets datarepo-helm/create-secret-manager-secret --version=0.0.4 --install --namespace dd -f ddSecrets.yaml
helm namespace upgrade dd-jade datarepo-helm/datarepo --version=0.1.6 --install --namespace dd -f ddDeployment.yaml
