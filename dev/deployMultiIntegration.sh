#!/bin/bash

NAMESPACES=("dd" "dev" "fb" "jh" "mk" "mm" "ms" "my" "rc" "sh")
helm repo add monster https://broadinstitute.github.io/monster-helm
helm repo update
for i in "${NAMESPACES[@]}"
do
   helm namespace upgrade ${i}-certificate  monster/gcp-managed-cert --version=0.1.1 --install --namespace ${i} -f "${i}/${i}Managedcert.yaml"
   helm namespace upgrade ${i}-secrets datarepo-helm/create-secret-manager-secret --version=0.0.4 --install --namespace ${i} -f "${i}/${i}Secrets.yaml"
   helm namespace upgrade ${i}-jade datarepo-helm/datarepo --version=0.1.5 --install --namespace ${i} -f "${i}/${i}Deployment.yaml"
   sleep 5
done
