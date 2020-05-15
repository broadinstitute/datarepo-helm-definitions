#!/bin/bash

helm repo add monster https://broadinstitute.github.io/monster-helm
helm repo update
helm namespace upgrade dd-certificate  monster/gcp-managed-cert --version=0.1.1 --install --namespace dd -f ddManagedcert.yaml
helm namespace upgrade dd-secrets datarepo-helm/create-secret-manager-secret --version=0.0.4 --install --namespace dd -f ddSecrets.yaml
helm namespace upgrade dd-jade datarepo-helm/datarepo --version=0.1.5 --install --namespace dd -f ddDeployment.yaml
