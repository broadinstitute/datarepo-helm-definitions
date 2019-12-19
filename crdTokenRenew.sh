set -e

# check to make sure vault and cloud env vars are set correctly
# set namespace to your initials
: ${NAMESPACE:?}
: ${DATAREPO_VAULT_TOKEN:?}


NEWTOKEN=$(vault token create -policy=datarepo-read-testpolicy -display-name=devtesttoken -ttl=43800m  | sed -n '3 s/token//p' | sed -e 's/\s\s*/\n/g' | openssl base64)
kubectl edit secrets secret-vault-crd-vault-token -n secret
