#!/bin/#!/usr/bin/env bash
# This script installs helm and the proper repositories and plugins
set -e

# check to make sure vault and cloud env vars are set correctly
# set namespace to your initials
: ${NAMESPACE:?}
: ${ENVIRONMENT:?}
WD=$( dirname "${BASH_SOURCE[0]}" )

# installs secrets
helm namespace install ${NAMESPACE} datarepo-helm/vault-secrets --namespace ${NAMESPACE} -f ${WD}/${ENVIRONMENT}/${NAMESPACE}/${NAMESPACE}Secrets.yaml --debug

# installs datarepo charts
helm install jade datarepo-helm/datarepo --namespace ${NAMESPACE} -f ${WD}/${ENVIRONMENT}/${NAMESPACE}/${NAMESPACE}Deployment.yaml --debug

# write sed for namespace


# upgrade charts
#helm upgrade jade datarepo-helm/datarepo --namespace ${NAMESPACE} -f ${WD}/${ENVIRONMENT}/${NAMESPACE}/${NAMESPACE}Deployment.yaml

# delete helm
#helm delete jade datarepo-helm/datarepo --namespace ${NAMESPACE}
