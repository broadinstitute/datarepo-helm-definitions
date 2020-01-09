#!/bin/#!/usr/bin/env bash
# This script installs helm and the proper repositories and plugins
set -e

# check to make sure vault and cloud env vars are set correctly
: ${DATAREPO_VAULT_ROLE_ID:?}
: ${DATAREPO_VAULT_SECRET_ID:?}
: ${VAULTCRD_NAMESPACE:=secrets}
: ${VAULT_PATH:=https://clotho.broadinstitute.org:8200}


# helm CRD check and install
helmvaultcrdinstall () {
if kubectl get pods --all-namespaces | grep "secrets-manager"; then
    echo "vaultCRD install found"
else
    helm namespace install jade datarepo-helm/install-secrets-manager  --namespace ${VAULTCRD_NAMESPACE} \
    --set vaultLocation=${VAULT_PATH} \
    --set serviceAccount.create=true \
    --set rbac.create=true \
    --set vaultVersion=kv1 \
    --set secretsgeneric.roleId=${DATAREPO_VAULT_ROLE_ID} \
    --set secretsgeneric.secretId=${DATAREPO_VAULT_SECRET_ID}
    #    --debug --dependency-update
fi
}

helmdeletevaultcrd () {
helm delete jade datarepo-helm/install-secrets-manager --namespace ${VAULTCRD_NAMESPACE}
}
