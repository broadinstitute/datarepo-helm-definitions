#!/bin/bash

NAMESPACES=("dd" "fb" "jh" "mk" "mm" "ms" "my" "rc" "sh")
helm repo update
for i in "${NAMESPACES[@]}"
do
   helm namespace upgrade ${i}-secrets datarepo-helm/create-secret-manager-secret --version=0.0.4 --install --namespace ${i} -f "${i}/${i}Secrets.yaml"
   helm namespace upgrade ${i}-jade datarepo-helm/datarepo --version=0.1.7 --install --namespace ${i} -f "${i}/${i}Deployment.yaml"
   sleep 3
done
