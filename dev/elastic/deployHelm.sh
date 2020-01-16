#! /#!/usr/bin/env bash

# helm elastic repo install mac
if helm repo list | grep -q "https://helm.elastic.co"; then
    echo "elastic repo found"
else
    echo "elastic repo not found installing"
    helm repo add datarepo-helm elastic https://helm.elastic.co
    helm repo update
fi
# namespace plugin
if helm plugin list | grep -q namespace; then
    echo "namespace plugin found"
else
    echo "namespace plugin not found installing"
    helm plugin install https://github.com/thomastaylor312/helm-namespace
fi

helm namespace install elasticsearch elastic/elasticsearch -n elasticsearch -f pocElastic.yaml
