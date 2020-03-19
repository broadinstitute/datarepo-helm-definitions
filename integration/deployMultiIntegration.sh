#!/bin/bash

NAMESPACES=("integration-1" "integration-2" "integration-3" "integration-4" "integration-5")

for i in "${NAMESPACES[@]}"
do
   helm namespace upgrade ${i}-secrets datarepo-helm/create-secret-manager-secret --version=0.0.4 --install --namespace ${i} -f "${i}/${i}Secrets.yaml"
   helm namespace upgrade ${i}-jade datarepo-helm/datarepo --version=0.0.8 --install --namespace ${i} -f "${i}/${i}Deployment.yaml"
   sleep 15
done
