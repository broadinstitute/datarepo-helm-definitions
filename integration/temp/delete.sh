#!/bin/bash

charts=("create-secret-manager-secret" "gcloud-sqlproxy" "datarepo-api" "datarepo-ui" "oidc-proxy")
namespace=temp
relase_name=chart-test

for i in "${charts[@]}"
do
   helm delete "${relase_name}-${i}" -n "${namespace}"
   sleep 5
done
