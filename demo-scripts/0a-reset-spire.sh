#!/bin/bash

export TUTORIAL_ROOT=/home/skraft
export APP_DOMAIN=apps.$(kubectl get dns cluster -o jsonpath='{ .spec.baseDomain }'); echo $APP_DOMAIN
export VAULT_ADDR=https://vault-vault.$APP_DOMAIN

oc delete ZeroTrustWorkloadIdentityManager cluster
oc delete SpireOIDCDiscoveryProvider cluster
oc delete SpiffeCSIDriver cluster
oc delete SpireAgent cluster
oc delete SpireServer cluster
oc delete pvc -l=app.kubernetes.io/managed-by=zero-trust-workload-identity-manager
oc delete csidriver -l=app.kubernetes.io/managed-by=zero-trust-workload-identity-manager
oc delete service -l=app.kubernetes.io/managed-by=zero-trust-workload-identity-manager
oc delete ns zero-trust-workload-identity-manager
oc delete clusterrolebinding -l=app.kubernetes.io/managed-by=zero-trust-workload-identity-manager
oc delete clusterrole -l=app.kubernetes.io/managed-by=zero-trust-workload-identity-manager
oc delete validatingwebhookconfigurations -l=app.kubernetes.io/managed-by=zero-trust-workload-identity-manager
oc delete crd spireservers.operator.openshift.io
oc delete crd spireagents.operator.openshift.io
oc delete crd spiffecsidrivers.operator.openshift.io
oc delete crd spireoidcdiscoveryproviders.operator.openshift.io
oc delete crd clusterfederatedtrustdomains.spire.spiffe.io
oc delete crd clusterspiffeids.spire.spiffe.io
oc delete crd clusterstaticentries.spire.spiffe.io
oc delete crd zerotrustworkloadidentitymanagers.operator.openshift.io

oc new-project zero-trust-workload-identity-manager
oc create -f spire-manifests/operatorGroup.yaml
oc create -f spire-manifests/subscription.yaml
oc apply -f spire-manifests/SpireServer.yaml
oc apply -f spire-manifests/SpireAgent.yaml


