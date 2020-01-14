!#/#!/usr/bin/env bash

helm repo add fluxcd https://charts.fluxcd.io
helm repo update
 helm namespace install helm-operator fluxcd/helm-operator -n fluxcd -f helm-operator.yaml
