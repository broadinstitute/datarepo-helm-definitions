## This directory is full of helper scripts

### Overview for Deployment
If this is your first time running any of these I would recommend running `InstallHelmv3.sh` then move on to running `helmChartHelper.sh` for pushing a deployment or deleting it.
###### The CRDs scripts are only required for a fresh Kubernertes deployment.

### helmInstallHelper.sh
`This Script contains functions that will install helm, helm repos and plugins needed to deploy Datarepo helm charts`
##### Usage
run the script
```
sh ./InstallHelmv3.sh
```
### helmChartHelper.sh
`This script is a helm wrapper that requires a NAMESPACE variable to run the Namespace var will be the users initials. The script contains 4 functions that can be called installsecrets, installdatarepo, deletesecrets and deletedatarepo`
##### Usage
```
sh ./helmChartHelper.sh <function> <userInitials>
---
sh ./helmChartHelper.sh installsecrets ms
sh ./helmChartHelper.sh installdatarepo ms
sh ./helmChartHelper.sh deletesecrets ms
sh ./helmChartHelper.sh deletedatarepo ms
```

### installHelmOperator.sh
`This script installs the helm-operator crd`

##### Usage
```
sh ./installHelmOperator.sh
```

### installSecretManager.sh
`This script requires approle_id and approle_secret values from vault`
[Vault Approle Docs](https://www.vaultproject.io/docs/auth/approle.html)
##### Usage
```
export DATAREPO_VAULT_ROLE_ID=<some_role_id>; export DATAREPO_VAULT_SECRET_ID=<some_secret_id>;

sh installSecretManager.sh
```
