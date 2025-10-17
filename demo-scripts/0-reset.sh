#!/bin/bash

export TUTORIAL_ROOT=/home/skraft
export APP_DOMAIN=apps.$(kubectl get dns cluster -o jsonpath='{ .spec.baseDomain }'); echo $APP_DOMAIN

oc delete project workload-identity-tutorial
echo "Workload Identity-Tutorial deleted!"

kubectl apply -f resources/baseline/namespace.yaml

cd $TUTORIAL_ROOT/cloudnativesecuritycon-workload-identity-tutorial

kubectl apply -f resources/baseline/namespace.yaml


