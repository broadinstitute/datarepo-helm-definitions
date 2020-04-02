#!/bin/bash
labels=("gcloud-sqlproxy" "datarepo-api" "datarepo-ui" "oidc-proxy")

for i in "${labels[@]}"
do
  kubectl get pods --namespace temp -l "app.kubernetes.io/name=${i}"
done
