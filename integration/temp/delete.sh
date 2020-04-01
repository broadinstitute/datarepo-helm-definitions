#!/bin/bash

charts=("gcloud-sqlproxy" "datarepo-api" "datarepo-ui" "oidc-proxy")
namespace=temp
relase_name=chart-test

helm delete "${relase_name}-secrets" -n "${namespace}"

for i in "${charts[@]}"
do
   helm delete "${relase_name}-${i}" -n "${namespace}"
   sleep 5
done
