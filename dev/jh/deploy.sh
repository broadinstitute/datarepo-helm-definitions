#!/bin/bash

helm namespace upgrade jh-secrets datarepo-helm/create-secret-manager-secret --version=0.0.4 --install --namespace jh -f jhSecrets.yaml
helm namespace upgrade jh-jade datarepo-helm/datarepo --version=0.0.8 --install --namespace jh -f jhDeployment.yaml
