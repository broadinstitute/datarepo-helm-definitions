# datarepo-helm-definitions

## Overview
This repository contains helm files for every Jade team member and environment. The core philosophy for the deployment is following [GITOPS](https://www.weave.works/blog/what-is-gitops-really) which means that the source of truth for the deployments will be this repository. The 3 key files each team member will have to track for their indivdual deployment are  `< initials >Deployment.yaml` and `< initials >Secrets.yaml`  These are end state definitions and may require some prerequisites.


### Helm Repositories
- [Datarepo-helm](https://github.com/broadinstitute/datarepo-helm)
- [helm Stable](https://github.com/helm/charts/tree/master/stable)


#### Helm list deployment
`helm ls -n <SomeNamspace>`

## Deleting a namespace or deployment manually is not advised as it will leave Rbac and Psp articfacts behind and they will need to be manually deleted

## If you deployed with helm you should delete your deployment with helm

#### Helm manual delete Examples
`helm destory <SomeDeploy> --namespace <SomeNamspace>`

`helm destroy jade --namespace <SomeNamspace>`

### Learn Helm!!
[Helm v3 Docs](https://helm.sh/docs/intro/)
