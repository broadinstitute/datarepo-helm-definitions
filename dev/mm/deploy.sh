#!/bin/bash

## Connect to the non-split Broad VPN.
## Connect to the gke_broad-jade-dev_us-central1_dev-master Kubernetes cluster.

## Refresh cluster credentials.
gcloud container clusters get-credentials dev-master --region us-central1 --project broad-jade-dev

## Update the helm charts.
helm repo update

charts=("create-secret-manager-secret" "gcloud-sqlproxy" "datarepo-api" "datarepo-ui" "oidc-proxy")
namespace=mm
release_name=${namespace}-jade

# New upgrade commands with the modular charts.
for i in "${charts[@]}"
do
   helm namespace upgrade ${release_name}-${i} datarepo-helm/${i} --install --namespace ${namespace} -f "${i}.yaml"
   sleep 5
done

# Previous upgrade command with umbrella chart.
# helm namespace upgrade mm-jade datarepo-helm/datarepo --version=0.1.12 --install --namespace mm -f mmDeployment.yaml

# Delete umbrella chart.
# helm namespace uninstall mm-jade --namespace mm
# helm namespace delete mm-secrets --namespace mm
# Then do the upgrade commands above.