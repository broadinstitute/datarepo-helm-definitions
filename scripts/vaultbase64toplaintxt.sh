#!/#!/usr/bin/env bash
declare -a initials=("dd" "dev" "jh" "mm" "ms" "my" "rc" )
env=dev
key=sa
declare -a pathprefixes=("secret/dsde/datarepo/${env}/sql-backup-" "secret/dsde/datarepo/${env}/sqlproxy-sa-")

for p in ${pathprefixes[@]};
do
  for i in ${initials[@]};
  do
    if vault read "${p}${i}-b64"; then
      newkeyval=$(vault read "${p}${i}-b64" --format=json | jq -r .data.${key} | base64 --decode)
      vault write ${p}${i} ${key}="${newkeyval}"
    else
      echo "vault key does not exist"
    fi
  done;
done;
