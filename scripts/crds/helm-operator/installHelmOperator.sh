#!/bin/bash

helm repo add fluxcd https://charts.fluxcd.io
helm repo update
kubectl apply -f https://raw.githubusercontent.com/fluxcd/helm-operator/1.0.0/deploy/crds.yaml

helm namespace upgrade -i helm-operator fluxcd/helm-operator -n fluxcd -f helm-operator.yaml
