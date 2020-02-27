# datarepo-helm-definitions

## Overview
This repository contains helm files for every Jade team member and environment. The core philosophy for the deployment is following [GITOPS](https://www.weave.works/blog/what-is-gitops-really) which means that the source of truth for the deployments will be this repository. The 3 key files each team member will have to track for their indivdual deployment are  `< initials >Deployment.yaml` and `< initials >Secrets.yaml`  These are end state definitions and may require some prerequisites.

### Prerequisites
- CRDS
  - [secrets-manager](https://github.com/tuenti/secrets-manager)
  - [Datarepo-helm repositories](https://github.com/broadinstitute/datarepo-helm)
- [helmv3](https://helm.sh/)

## Deployment Overview
### Install CRDS
#### [secrets-manager](https://github.com/tuenti/secrets-manager)
- secrets-manager will login to Vault using AppRole credentials and it will start a reconciliation loop watching for changes in SecretsDefinition objects. In background it will run two main operations:

- If Vault token is close to expire and if that's the case, renewing it. If it can't renew, it will try to re-login.
- It will re-queue SecretsDefinition events and in every event loop it will verify if the current Kubernetes secret it is in the desired state by comparing it with the data in Vault and creating/updating them accordingly


#### Create namespaces
- helm 3 no longer support the creation of namespaces
- namespace will be created by [namepace plugin required](https://github.com/thomastaylor312/helm-namespace)


Helm values are derived from the URL as a source of truth for the deployment if you would like to manually over write a field without commiting to master you can set the following field in the yaml

### Deployment files

#### < initials >Secrets.yaml
- Contains all secret locations in vault and uses the secret-manager crd to sync between vault and [kubernetes secrets](https://kubernetes.io/docs/concepts/configuration/secret/)
- ##### THIS MUST BE INSTALLED  BEFORE THE < initials >Deployment.yaml IF MANUALLY INSTALLED

#### < initials >Deployment.yaml
- Contains all values for the complete [datarepo helm chart](https://github.com/broadinstitute/datarepo-helm/tree/master/charts/datarepo)
-  This chart references 4 sub charts

- < initials >Secrets.yaml will be installed first
- < initials >Deployment.yaml will be installed second

### TLDR deployment process
- ##### [Script Documentation](https://github.com/broadinstitute/datarepo-helm-definitions/blob/master/scripts/README.md)

- ##### install crd secret-manager
  - `sh ./scripts/crds/secret-manager/installSecretManager.sh`
    - [installSecretManager.sh](https://github.com/broadinstitute/datarepo-helm-definitions/blob/master/scripts/crds/secrets-manager/installSecretManager.sh)

## One click helm install script for osx
Run [`$sh ./helmInstallHelper.sh`](https://github.com/broadinstitute/datarepo-helm-definitions/blob/master/scripts/helmInstallHelper.sh)



## Folder Structure
```
├── README.md
├── dev  <--- ENVIRONMENT
│   ├── dd
│   ├── dev
│   ├── jh
│   ├── mm
│   ├── ms  <--- user initials set $ENVIRONMENT to this for helper script
│       ├── msDeployment.yaml  <--- Datarepo Helm Deployment Values
|       └── msSecrets.yaml  <--- Datarepo Helm Secrets Values
│  
│  
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

## Deleting a namespace or deployment manually is not advised as it will leave Rbac and Psp articfacts behind and they will need to be manually deleted

## If you deployed with helm you should delete your deployment with helm

#### Helm list deployment
`helm ls -n <SomeNamspace>`

#### Helm manual installs Examples ([namepace plugin required](https://github.com/thomastaylor312/helm-namespace) below)
`helm namespace upgrade temp-secrets datarepo-helm/create-secret-manager-secret --version=0.0.4 --install --namespace temp -f tempSecrets.yaml`

`helm namespace upgrade temp-jade datarepo-helm/datarepo --version=0.0.6 --install --namespace temp -f tempDeployment.yaml
`
#### Helm manual delete Examples
`helm delete <SomeDeploy> --namespace <SomeNamspace>`

`helm delete jade --namespace <SomeNamspace>`

### Learn Helm!!
[Helm v3 Docs](https://helm.sh/docs/intro/)
