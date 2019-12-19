## This directory is full of helper scripts

### Scripts
- helmInstallHelper.sh
- helmChartHelper.sh
- vaultCrdHelper.sh
- vaultbase64toplaintxt.sh

### helmInstallHelper.sh
`This Script contains functions that will install helm, helm repos and plugins needed to deploy Datarepo helm charts`
##### Functions
- helminstall
  - installs helm
- helmrepoinstall
  - installs helm repos stable, datarepo-helm, vault-crd and updates repos
- helmplugininstall
  - installs namespace creation helm pluin
- helmisntallall
  - installs all of the above
##### Usage
first source the script
```
source ./helmInstallHelper.sh
```
Then call a functions from the list above
```
helmisntallall
```

### helmChartHelper.sh
`This script helps install charts for this repository ie: secrets and deployment charts`
##### Prerequisites
- [vault-crd](https://github.com/broadinstitute/vault-crd-helm) must be installed
-  see vaultCrdHelper.sh

##### Functions
- helminstallsecrets
  - creates namespace, helm deployment and syncs secrets from `<initials>Secrets.yaml` in users folder
- helmdeletesecrets
  - Deletes helm Secrets deployment
- helminstalldeploy
  - must be ran with existing kubernetes secrets in place see `helminstallsecrets`
  - creates namespace, helm deployment for a Datarepo deployment
- helmupgradedeploy
  - upgrades an existing Deployment
- helmdeletedeploy
  - deletes an existing deployment
  ##### Usage
  Set ENVIRONMENT vars
  ```
export NAMESPACE=<initials>
export ENVIRONMENT=<dev, integration, prod>
  ```
  first source the script
  ```
  source ./helmChartHelper.sh
  ```
  Then call a functions from the list above
  ```
  helminstallsecrets
  helminstalldeploy
  ```
### vaultCrdHelper.sh
