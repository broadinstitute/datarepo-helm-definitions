#!/bin/#!/usr/bin/env bash
# This script installs helm and the proper repositories and plugins
set -e

# check to make sure vault and cloud env vars are set correctly
# set namespace to your initials
: ${NAMESPACE:?}
: ${ENVIRONMENT:?}
WD=$( dirname "${BASH_SOURCE[0]}" )

# installs secrets
helminstallsecrets () {
helm namespace install ${NAMESPACE}-secrets datarepo-helm/create-secret-manager-secret --namespace ${NAMESPACE} -f ${WD}/../${ENVIRONMENT}/${NAMESPACE}/${NAMESPACE}Secrets.yaml --debug
}

# delete secrets deploy
helmdeletesecrets () {
helm delete ${NAMESPACE}-secrets --namespace ${NAMESPACE}
}

# installs datarepo charts
helminstalldeploy () {
helm namespace install jade datarepo-helm/datarepo --namespace ${NAMESPACE} -f ${WD}/../${ENVIRONMENT}/${NAMESPACE}/${NAMESPACE}Deployment.yaml --debug
}

# upgrade charts
helmupgradedeploy () {
helm upgrade jade datarepo-helm/datarepo --namespace ${NAMESPACE} -f ${WD}/../${ENVIRONMENT}/${NAMESPACE}/${NAMESPACE}Deployment.yaml
}

# delete helm
helmdeletedeploy () {
helm delete jade --namespace ${NAMESPACE}
}
