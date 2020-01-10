!#/#!/usr/bin/env bash

helm repo add fluxcd https://charts.fluxcd.io
helm repo update
kubectl apply -f https://raw.githubusercontent.com/fluxcd/helm-operator/master/deploy/flux-helm-release-crd.yaml
helm upgrade -i helm-operator fluxcd/helm-operator \
--namespace fluxcd \
--set helm.versions=v3
 helm namespace install helm-operator fluxcd/helm-operator -n fluxcd -f helm-operator.yaml
