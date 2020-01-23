#!/bin/#!/usr/bin/env bash
# This script installs helm and the proper repositories and plugins
set -e

# check to make sure vault and cloud env vars are set correctly
: ${DATAREPO_VAULT_ROLE_ID:?}
: ${DATAREPO_VAULT_SECRET_ID:?}
: ${VAULTCRD_NAMESPACE:=secrets}
: ${VAULT_PATH:=https://clotho.broadinstitute.org:8200}

#kubectl apply -f https://raw.githubusercontent.com/tuenti/secrets-manager/master/config/crd/bases/secrets-manager.tuenti.io_secretdefinitions.yaml

helm namespace install dev datarepo-helm/install-secrets-manager  --namespace ${VAULTCRD_NAMESPACE} \
--set vaultLocation=${VAULT_PATH} \
--set serviceAccount.create=true \
--set rbac.create=true \
--set vaultVersion=kv1 \
--set secretsgeneric.roleId=${DATAREPO_VAULT_ROLE_ID} \
--set secretsgeneric.secretId=${DATAREPO_VAULT_SECRET_ID} \
--debug

