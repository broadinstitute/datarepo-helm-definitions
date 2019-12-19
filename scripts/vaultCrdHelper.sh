#!/bin/#!/usr/bin/env bash
# This script installs helm and the proper repositories and plugins
set -e

# check to make sure vault and cloud env vars are set correctly
: ${DATAREPO_VAULT_TOKEN:?}
: ${VAULTCRD_NAMESPACE:=secrets}
: ${VAULT_PATH:=https://clotho.broadinstitute.org:8200}


# helm CRD check and install
helmvaultcrdinstall () {
if kubectl get pods --all-namespaces | grep "vault-crd"; then
    echo "vaultCRD install found"
else
    helm namespace install ${VAULTCRD_NAMESPACE} vault-crd/vault-crd  --namespace ${VAULTCRD_NAMESPACE} \
    --set vaultCRD.vaultUrl=${VAULT_PATH} \
    --set vaultCRD.vaultToken=${DATAREPO_VAULT_TOKEN} \
    --debug --dependency-update
fi
}

helmdeletevaultcrd () {
helm delete ${VAULTCRD_NAMESPACE} vault-crd/vault-crd --namespace ${VAULTCRD_NAMESPACE}
}

manualvaultcrdcleanup() {
kubectl delete namespace ${VAULTCRD_NAMESPACE}
kubectl delete PodSecurityPolicy secrets-vault-crd-pod-running-policy
kubectl delete clusterrole vault-crd-clusterrole
kubectl delete ClusterRoleBinding vault-crd-clusterrole-binding
}

helmvaultcrdtokenupdate () {
set -e
: ${VAULTPOLICY:?}
NEWTOKEN=$(vault token create -policy=${VAULTPOLICY} -display-name=devtesttoken -ttl=43800m  | sed -n '3 s/token//p' | sed -e 's/\s\s*/\n/g')
helm upgrade ${VAULTCRD_NAMESPACE} vault-crd/vault-crd --namespace ${VAULTCRD_NAMESPACE} \
--set vaultCRD.vaultUrl=${VAULT_PATH} \
--set vaultCRD.vaultToken=${NEWTOKEN} \
--recreate-pods \
--debug
}
