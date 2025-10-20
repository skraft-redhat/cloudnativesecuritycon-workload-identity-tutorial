#!/bin/bash

export TUTORIAL_ROOT=/home/skraft
export APP_DOMAIN=apps.$(kubectl get dns cluster -o jsonpath='{ .spec.baseDomain }'); echo $APP_DOMAIN
export VAULT_ADDR=https://vault-vault.$APP_DOMAIN

oc delete project workload-identity-tutorial
echo "Workload Identity-Tutorial deleted!"

kubectl apply -f resources/baseline/namespace.yaml



