#!/bin/bash

NAMESPACES=("dd" "dev" "fb" "jh" "mk" "mm" "ms" "my" "rc" "sh")

for i in "${NAMESPACES[@]}"
do
   helm namespace upgrade ${i}-secrets datarepo-helm/create-secret-manager-secret --version=0.0.4 --install --namespace ${i} -f "${i}/${i}Secrets.yaml"
   helm namespace upgrade ${i}-jade datarepo-helm/datarepo --version=0.1.0 --install --namespace ${i} -f "${i}/${i}Deployment.yaml"
   sleep 10
done
