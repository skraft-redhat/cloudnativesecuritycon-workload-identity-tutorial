#!/bin/bash

export TUTORIAL_ROOT=/home/skraft
export APP_DOMAIN=apps.$(kubectl get dns cluster -o jsonpath='{ .spec.baseDomain }'); echo $APP_DOMAIN


kubectl apply -f $TUTORIAL_ROOT/cloudnativesecuritycon-workload-identity-tutorial/resources/baseline/db.yaml

envsubst < $TUTORIAL_ROOT/cloudnativesecuritycon-workload-identity-tutorial/resources/baseline/py.yaml | kubectl apply -f -

kubectl get cm -n workload-identity-tutorial db-config -o jsonpath='{ .data.config\.ini }' > $TUTORIAL_ROOT/cloudnativesecuritycon-workload-identity-tutorial/resources/secure/vault/config.ini

SHA64=$(openssl base64 -in $TUTORIAL_ROOT/cloudnativesecuritycon-workload-identity-tutorial/resources/secure/vault/config.ini)

export ROOT_TOKEN=$(kubectl -n vault logs $(kubectl -n vault get po | grep vault-| awk '{print $1}') | grep Root | cut -d' ' -f3); echo "export ROOT_TOKEN=$ROOT_TOKEN"

vault login -no-print "${ROOT_TOKEN}"

vault kv put secret/db-config/config.ini sha="$SHA64"
