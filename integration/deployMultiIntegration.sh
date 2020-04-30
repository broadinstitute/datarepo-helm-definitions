#!/bin/bash

NAMESPACES=("integration-1" "integration-2" "integration-3" "integration-4" "integration-5")

helm repo add monster https://broadinstitute.github.io/monster-helm
helm repo update
for i in "${NAMESPACES[@]}"
do
   helm namespace upgrade ${i}-certificate  monster/gcp-managed-cert --version=0.1.1 --install --namespace ${i} -f ${i}Managedcert.yaml
   helm namespace upgrade ${i}-secrets datarepo-helm/create-secret-manager-secret --version=0.0.4 --install --namespace ${i} -f "${i}/${i}Secrets.yaml"
   helm namespace upgrade ${i}-jade datarepo-helm/datarepo --version=0.1.2 --install --namespace ${i} -f "${i}/${i}Deployment.yaml"
   sleep 5
done
