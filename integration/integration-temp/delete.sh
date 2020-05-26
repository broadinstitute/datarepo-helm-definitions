#!/bin/bash

charts=("create-secret-manager-secret" "gcloud-sqlproxy" "datarepo-api" "datarepo-ui" "oidc-proxy")
namespace=integration-temp
relase_name=integration-temp-jade

for i in "${charts[@]}"
do
   helm delete "${relase_name}-${i}" -n "${namespace}"
   sleep 5
done
