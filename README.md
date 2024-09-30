# datarepo-helm-definitions

### Holdover repository until [datarepo-helm](https://github.com/broadinstitute/datarepo-helm) is fully migrated to [terra-helmfile](https://github.com/broadinstitute/terra-helmfile) to enable testing of helm chart changes.

## Overview
This repository used to contain the helm files for every Terra Data Repo (TDR) environment and personal developer environments. All
helm definitions for the main data repo environments (Dev, Staging and production) have been moved to [Terra-Helmfile](https://github.com/broadinstitute/terra-helmfile).

However, until datarepo-helm is fully migrated to terra-helmfile, these charts are the only way to test helm chart changes.

We need to test changes relatively infrequently, so we expect for users to spin up and shut down their own environments as needed.


### Testing with Personal Environments

### Prerequisites
* Clone the [datarepo-helm-definitions](https://github.com/broadinstitute/datarepo-helm-definitions) repository
* Install needed resources: helm and helmfile
```
brew install helm
brew install helmfile
```
* Connect to the non-split VPN
* Connect to the dev cluster
```
gcloud auth login
gcloud container clusters get-credentials dev-master --region us-central1 --project broad-jade-dev
```

### Spin up environment 
Note: It can take up to 10-15 minutes for an environment to fully spin up (ingress and cert creation)
1. Select a namespace to work in. These previously used to be named after a developer, but they are now available for general use. (Available options include: nm, ok, ps, se, and sh). We'll refer to these initials as `ZZ` in these instructions.
2. Change directory to a namespace folder in `datarepo-helm-definitions` (e.g. `cd datarepo-helm-definitions/dev/ZZ`)
and run `helmfile apply` to spin up the environment.
```
cd datarepo-helm-definitions/dev/ZZ
helmfile apply

# check that the deployments were created
helm list --namespace ZZ
```
4. You can access the instance at the following address: `https://jade-ZZ.datarepo-dev.broadinstitute.org`
5. You can connect to the postgres instance in the SQL studio in the broad-jade-dev google project. The database password is
in the secret manager. 


### When finished testing, shut down the environment by running `helmfile destroy`
```
cd datarepo-helm-definitions/dev/ZZ
helmfile destroy
```

**Note: Deleting a namespace or deployment manually/in the gcloud console is not advised as it will leave Rbac and Psp
artifacts behind and they will need to be manually deleted.
If you deployed with helm you should delete your deployment with helm.**

**Helpful hints**

By default, you can leave release chart versions unspecified in your `helmfile.yaml` so that  latest versions are
automatically picked up when running helmfile commands. Otherwise, verify that specified versions match the
   [latest dependency versions](https://github.com/broadinstitute/datarepo-helm/blob/master/charts/datarepo/Chart.lock).
