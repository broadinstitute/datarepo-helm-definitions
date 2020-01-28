#!/bin/#!/usr/bin/env bash
# This script installs helm and the proper repositories and plugins
set -e

# check to make sure vault and cloud env vars are set correctly
# set namespace to your initials
#: ${NAMESPACE:?}
: ${ENVIRONMENT:=dev}
WD=$( dirname "${BASH_SOURCE[0]}" )

# installs secrets
installsecrets () {
helm namespace upgrade ${NAMESPACE}-secrets datarepo-helm/create-secret-manager-secret --version=0.0.4 --install --namespace ${NAMESPACE} -f ${WD}/../${ENVIRONMENT}/${NAMESPACE}/${NAMESPACE}Secrets.yaml
}


# delete secrets deploy
deletesecrets () {
helm delete ${NAMESPACE}-secrets --namespace ${NAMESPACE}
}

# installs datarepo charts
installdatarepo () {
helm namespace upgrade ${NAMESPACE}-jade datarepo-helm/datarepo --version=0.0.4 --install --namespace ${NAMESPACE} -f ${WD}/../${ENVIRONMENT}/${NAMESPACE}/${NAMESPACE}Deployment.yaml
}


# delete helm
deletedatarepo () {
helm delete ${NAMESPACE}-jade --namespace ${NAMESPACE}
}

function main () {

local -r NAMESPACE=$2
$1

}

main ${@}
