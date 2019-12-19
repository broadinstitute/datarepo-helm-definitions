# datarepo-helm-definitions

## Overview
This repository contains helm `value.yaml` files for every Jade team member and environment. These are end state definitions and my require some prerequisites.

### Prerequisites
- helmv3
- helm namespace plugin
- helm repositories
  - datarepo-helm

## One click helm install script for osx
Run [`$ ./helmInstallHelper.sh helminstallall`](https://github.com/broadinstitute/datarepo-helm-definitions/blob/master/scripts/helmInstallHelper.sh)

## TLDR Full Deployment
1. Connect to kubernetes cluster

- `gcloud container clusters get-credentials dev-cluster --region us-central1 --project broad-some-proj`
2. deploy vault-crd to a standalone NAMESPACE
- Run [`$ ./vaultCrdHelper.sh helmvaultcrdinstall`](https://github.com/broadinstitute/datarepo-helm-definitions/blob/master/scripts/vaultCrdHelper.sh)
3. deploy secrets to a datarepo deployment namespace
- Run [`$ ./helmChartHelper.sh helminstallsecrets`](https://github.com/broadinstitute/datarepo-helm-definitions/blob/master/scripts/helmChartHelper.sh)
4. deploy datarepo helm chart to deployment namespace
- Run [`$ ./helmChartHelper.sh helminstalldeploy`](https://github.com/broadinstitute/datarepo-helm-definitions/blob/master/scripts/helmChartHelper.sh)

### TLDR Short Deployment (Assumes vaultCRD is already installed)
1. deploy secrets to a datarepo deployment namespace
- Run [`$ ./helmChartHelper.sh helminstallsecrets`](https://github.com/broadinstitute/datarepo-helm-definitions/blob/master/scripts/helmChartHelper.sh)
2. deploy datarepo helm chart to deployment namespace
- Run [`$ ./helmChartHelper.sh helminstalldeploy`](https://github.com/broadinstitute/datarepo-helm-definitions/blob/master/scripts/helmChartHelper.sh)

## Folder Structure
```
├── README.md
├── dev  <--- ENVIRONMENT
│   ├── dd
│   ├── dev
│   ├── jh
│   ├── mm
│   ├── ms  <--- user initials set $ENVIRONMENT to this for helper script
│   │   ├── msDeployment.yaml  <--- Datarepo Deployment Values
│   │   └── msSecrets.yaml  <--- Datarepo Secrets Values
│   ├── my
│   └── rc
├── integration
├── prod
└── scripts  <-- Helper scripts for static folder structure
    ├── README.md
    ├── helmChartHelper.sh
    ├── helmInstallHelper.sh
    ├── vaultCrdHelper.sh
    └── vaultbase64toplaintxt.sh
```
### Helm Repositories
- [Datarepo-helm](https://github.com/broadinstitute/datarepo-helm)
- [helm Stable](https://github.com/helm/charts/tree/master/stable)
- [vault-crtd](https://github.com/broadinstitute/vault-crd-helm)

## Helm manual installs Examples
`helm namespace install <MyDeployName> datarepo-helm/vault-secrets --namespace <SomeNamspace> -f Secrets.yaml`

`helm namespace install <MyDeployName> datarepo-helm/datarepo --namespace <SomeNamspace> -f Deployment.yaml --debug
`
## Helm manual upgrade Examples
`helm upgrade <MyDeployName> datarepo-helm/datarepo --namespace <SomeNamspace> -f Deployment.yaml`
## Helm manual delete Examples
`helm delete <SomeNamspace> --namespace <SomeNamspace>`

`helm delete jade --namespace <SomeNamspace>`

### Learn Helm!!
[Helm v3 Docs](https://helm.sh/docs/intro/)
