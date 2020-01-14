## This directory is full of helper scripts

### Scripts
```
├── crds
│   ├── helm-operator
│   │   ├── helm-operator.yaml <--- helm chart yaml to install crd
│   │   └── installHelmOperator.sh <--- installation wrapper script for helm-operator
│   └── secret-manager
│       ├── devNamespaces.yaml <--- manual kubernetes dev namespace creation yaml
│       └── installSecretManager.sh <--- installation wrapper for secret-manager
├── helmChartHelper.sh <--- no longer used helm wrapper script
└── helmInstallHelper.sh <--- one shot helm installation script
```


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
run the script
```
sh ./helmInstallHelper.sh
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
