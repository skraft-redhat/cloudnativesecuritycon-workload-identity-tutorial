#!/bin/bash

export TUTORIAL_ROOT=/home/skraft
export APP_DOMAIN=apps.$(kubectl get dns cluster -o jsonpath='{ .spec.baseDomain }'); echo $APP_DOMAIN


kubectl apply -f $TUTORIAL_ROOT/cloudnativesecuritycon-workload-identity-tutorial/resources/baseline/db.yaml

envsubst < $TUTORIAL_ROOT/cloudnativesecuritycon-workload-identity-tutorial/resources/baseline/py.yaml | kubectl apply -f -
