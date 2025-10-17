#!/bin/bash

export TUTORIAL_ROOT=/home/skraft
export APP_DOMAIN=apps.$(kubectl get dns cluster -o jsonpath='{ .spec.baseDomain }'); echo $APP_DOMAIN


envsubst < $TUTORIAL_ROOT/cloudnativesecuritycon-workload-identity-tutorial/resources/secure/apps/spire-debug.yaml | kubectl apply -f -

