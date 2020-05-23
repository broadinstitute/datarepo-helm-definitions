#!/bin/bash
helm namespace upgrade ms-secrets datarepo-helm/create-secret-manager-secret --version=0.0.4 --install --namespace ms -f msSecrets.yaml
helm namespace upgrade ms-jade datarepo-helm/datarepo --version=0.1.6 --install --namespace ms -f msDeployment.yaml
