#!/bin/#!/usr/bin/env bash
# This script installs helm and the proper repositories and plugins

# helm install mac
helminstall () {
if helm version; then
    echo "helm install found"
else
    echo "installing  helm"
    brew install helm
fi
}

# helm repo install mac
helmrepoinstall () {
if helm repo list | grep -q "https://kubernetes-charts.storage.googleapis.com/"; then
    echo "stable repo found"
else
    echo "stable repo not found installing"
    helm repo add stable https://kubernetes-charts.storage.googleapis.com/
fi

# helm datarepo repo install mac
if helm repo list | grep -q "https://broadinstitute.github.io/datarepo-helm"; then
    echo "datarepo-helm repo found"
else
    echo "datarepo-helm repo not found installing"
    helm repo add datarepo-helm https://broadinstitute.github.io/datarepo-helm
fi

# helm vaultCRD repo install mac
if helm repo list | grep -q "https://raw.githubusercontent.com/broadinstitute/vault-crd-helm/master"; then
    echo "vault-crd repo found"
else
    echo "vault-crd repo not found installing"
    helm repo add vault-crd https://raw.githubusercontent.com/broadinstitute/vault-crd-helm/master
fi

helm repo update
}

# check for namespace plugin this may not be needed once helm v3.1 drops
helmplugininstall () {
if helm plugin list | grep -q namespace; then
    echo "namespace plugin found"
else
    echo "namespace plugin not found installing"
    helm plugin install https://github.com/thomastaylor312/helm-namespace
fi
}

helmall () {
helminstall
helmrepoinstall
helmplugininstall
}
