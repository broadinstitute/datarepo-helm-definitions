#!/bin/bash
helm repo add monster https://broadinstitute.github.io/monster-helm
helm repo update
helm namespace upgrade ms-certificate  monster/gcp-managed-cert --version=0.1.1 --install --namespace ms -f msManagedcert.yaml
helm namespace upgrade ms-secrets datarepo-helm/create-secret-manager-secret --version=0.0.4 --install --namespace ms -f msSecrets.yaml
helm namespace upgrade ms-jade datarepo-helm/datarepo --version=0.1.2 --install --namespace ms -f msDeployment.yaml
