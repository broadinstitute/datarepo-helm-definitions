#!/bin/bash

charts=("create-secret-manager-secret" "gcloud-sqlproxy" "datarepo-api" "datarepo-ui" "oidc-proxy")
namespace=dd
relase_name=${namespace}-jade

helm repo update
for i in "${charts[@]}"
do
   helm namespace upgrade ${relase_name}-${i} datarepo-helm/${i} --install --namespace ${namespace} -f "${i}.yaml"
   sleep 5
done
