# datarepo-helm-definitions

## Overview
This repository contains helm files for every Jade team member and environment. The core philosophy for the deployment is following [GITOPS](https://www.weave.works/blog/what-is-gitops-really) which means that the source of truth for the deployments will be this repository. The 3 key files each team member will have to track for their indivdual deployment are  `< initials >Deployment.yaml`,`< initials >HelmOperator.yaml` and `< initials >Secrets.yaml`  These are end state definitions and may require some prerequisites.

### Prerequisites
- CRDS
  - [helm-operator](https://github.com/fluxcd/helm-operator)
  - [secrets-manager](https://github.com/tuenti/secrets-manager)
  - [Datarepo-helm repositories](https://github.com/broadinstitute/datarepo-helm)
- [helmv3](https://helm.sh/)

## Deployment Overview
### Install CRDS
#### [secrets-manager](https://github.com/tuenti/secrets-manager)
- secrets-manager will login to Vault using AppRole credentials and it will start a reconciliation loop watching for changes in SecretsDefinition objects. In background it will run two main operations:

- If Vault token is close to expire and if that's the case, renewing it. If it can't renew, it will try to re-login.
- It will re-queue SecretsDefinition events and in every event loop it will verify if the current Kubernetes secret it is in the desired state by comparing it with the data in Vault and creating/updating them accordingly
#### [helm-operator](https://github.com/fluxcd/helm-operator)
- The Helm Operator provides an extension to Flux that automates Helm Chart releases
- declarative helm install/upgrade/delete of charts
- pulls charts from public or private Helm repositories over HTTPS
- pulls charts from public or private Git repositories over SSH
- chart release values can be specified inline in the - HelmRelease object or via secrets, configmaps or URLs
- automated chart upgrades based on container image tag policies (requires Flux)
- automatic purging on chart install failures
- automatic rollback on chart upgrade failures
- supports both Helm v2 and v3
![GitOps Helm Operator](https://github.com/fluxcd/helm-operator/raw/master/docs/_files/fluxcd-helm-operator-diagram.png)

#### Create namespaces
- helm 3 no longer support the creation of namespaces before the helm-operator can deploy, every namespace must exist
- for dev a simple `kubectl apply -f scripts/crds/secret-manager/devNamespaces.yaml` can be ran to create namespaces

#### Deploy helm-operator kubernetes yaml
- Once the crds and namespaces are deployed you are ready to deploy some helm charts or in this case the [helm-operator](https://github.com/fluxcd/helm-operator) will do this for you
- <b>The [helm-operator](https://github.com/fluxcd/helm-operator) yaml config not is a Helm chart yaml it is a kubernetes yaml</b>

- `kubectl apply -f < initials >HelmOperator.yaml --namespace < initials >`

### Sample [helm-operator](https://github.com/fluxcd/helm-operator)  config file

```
---
apiVersion: helm.fluxcd.io/v1 <-- kubernetes api
kind: HelmRelease <-------------- kind of config
metadata:
  name: ms-secrets <------------- crd metadata name
  namespace: ms <---------------- namespace for crd deployment
spec:
  releaseName: secrets <--------- helm deploy release name
  targetNamespace: ms <---------- namespace to deploy chart to
  timeout: 300
  resetValues: false
  forceUpgrade: false
  chart:
    repository: https://broadinstitute.github.io/datarepo-helm/ <-- helm repository
    name: create-secret-manager-secret <-- helm chart name
    version: 0.0.4 <---------------------- helm chart version
  valuesFrom:
  - externalSourceRef: <--------- helm values.yaml external reference file
      url: https://raw.githubusercontent.com/broadinstitute/datarepo-helm-definitions/master/dev/ms/msSecrets.yaml
```
Helm values are derived from the URL as a source of truth for the deployment if you would like to manually over write a field without commiting to master you can set the following field in the yaml
```
---
apiVersion: helm.fluxcd.io/v1
kind: HelmRelease
metadata:
  name: ms-datarepo
  namespace: ms
spec:
  releaseName: ms-jade
  targetNamespace: ms
  timeout: 300
  resetValues: false
  forceUpgrade: false
  chart:
    repository: https://broadinstitute.github.io/datarepo-helm/
    name: datarepo
    version: 0.0.4
  values: <------------------------------------------- Override field
    datarepo-api: <----------------------------------- Override field
      image: <---------------------------------------- Override field
        version: fake-jade-ms_2019-12-05_13-20-26 <--- Override field
  valuesFrom:
  - externalSourceRef:
      url: https://raw.githubusercontent.com/broadinstitute/datarepo-helm-definitions/master/dev/ms/msDeployment.yaml
```
This values field accepts any input a helm chart would accept
```  
values:
  datarepo-api:
    image:
      version: fake-jade-ms_2019-12-05_13-20-26
```

[See the Helm-Operator documentation for information here](https://docs.fluxcd.io/projects/helm-operator/en/latest/references/helmrelease-custom-resource.html)

### Deployment files

#### < initials >Secrets.yaml
- Contains all secret locations in vault and uses the secret-manager crd to sync between vault and [kubernetes secrets](https://kubernetes.io/docs/concepts/configuration/secret/)
- ##### THIS MUST BE INSTALLED  BEFORE THE < initials >Deployment.yaml IF MANUALLY INSTALLED

#### < initials >Deployment.yaml
- Contains all values for the complete [datarepo helm chart](https://github.com/broadinstitute/datarepo-helm/tree/master/charts/datarepo)
-  This chart references 4 sub charts

#### < initials >HelmOperator.yaml
- Contains helm-operator configuration to point to two helm deployments
- < initials >Secrets.yaml will be installed first
- < initials >Deployment.yaml will be installed second

### TLDR deployment process
- ##### [Script Documentation](https://github.com/broadinstitute/datarepo-helm-definitions/blob/master/scripts/README.md)

- ##### install crd secret-manager and helm-operator
  - `sh ./scripts/crds/secret-manager/installSecretManager.sh`
    - [installSecretManager.sh](https://github.com/broadinstitute/datarepo-helm-definitions/blob/master/scripts/crds/helm-operator/installHelmOperator.sh)
  - `sh ./scripts/crds/helm-operator/installHelmOperator.sh`
    - [installHelmOperator.sh](https://github.com/broadinstitute/datarepo-helm-definitions/blob/master/scripts/crds/secret-manager/installSecretManager.sh)
- ##### create namespaces
  - `kubectl apply -f scripts/crds/secret-manager/devNamespaces.yaml`
- ##### deploy helm-operator yaml
  - `kubectl apply -f < environment >/< initials >/< initials >HelmOperator.yaml --namepace < initials >`

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
│       ├── msHelmOperator.yaml <--- Kubernetes yaml for helm-operator crd
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
- [vault-crtd](https://github.com/broadinstitute/vault-crd-helm)

## Deleting a namespace or deployment manually is not advised as it will leave Rbac and Psp articfacts behind and they will need to be manually deleted

## If you deployed with helm you should delete your deployment with helm

#### Helm list deployment
`helm ls -n <SomeNamspace>`

#### Helm manual installs Examples
`helm install <MyDeployName> datarepo-helm/vault-secrets --namespace <SomeNamspace> -f Secrets.yaml`

`helm install <MyDeployName> datarepo-helm/datarepo --namespace <SomeNamspace> -f Deployment.yaml --debug
`
#### Helm manual upgrade Examples
`helm upgrade <MyDeployName> datarepo-helm/datarepo --namespace <SomeNamspace> -f Deployment.yaml`
#### Helm manual delete Examples
`helm delete <SomeDeploy> --namespace <SomeNamspace>`

`helm delete jade --namespace <SomeNamspace>`

### Learn Helm!!
[Helm v3 Docs](https://helm.sh/docs/intro/)
