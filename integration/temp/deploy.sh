#!/bin/bash

charts=("gcloud-sqlproxy" "datarepo-api" "datarepo-ui" "oidc-proxy")
namespace=temp
relase_name=chart-test

helm namespace upgrade ${relase_name}-secrets datarepo-helm/create-secret-manager-secret --version=0.0.4 --install --namespace ${namespace} -f "${namespace}Secrets.yaml"

for i in "${charts[@]}"
do
   helm namespace upgrade ${relase_name}-${i} datarepo-helm/${i} --install --namespace ${namespace} -f "${i}.yaml"
   sleep 5
done
