#!/bin/bash

charts=("create-secret-manager-secret" "gcloud-sqlproxy" "datarepo-api" "datarepo-ui" "oidc-proxy")
namespace=temp
relase_name=chart-test
pathtocharts=
#helm namespace upgrade temp-certificate  monster/gcp-managed-cert --install --namespace temp -f managedcert.yaml
for i in "${charts[@]}"
do
   helm namespace upgrade ${relase_name}-${i} datarepo-helm/${i} --install --namespace ${namespace} -f "${i}.yaml"
   sleep 5
done
