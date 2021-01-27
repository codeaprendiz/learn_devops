#!/usr/bin/env bash


# Encoding the .csr file in base64
export BASE64_CSR=$(cat ./dave.csr | base64 | tr -d '\n')
# Substitution of the BASE64_CSR env variable and creation of the CertificateSigninRequest resource
cat csr.yaml | envsubst | kubectl apply -f -

kubectl get csr

kubectl certificate approve mycsr

kubectl get csr

kubectl get csr mycsr -o jsonpath='{.status.certificate}' \
  | base64 --decode > dave.crt


kubectl apply -f dev-ns.yaml

kubectl apply -f role.yaml

kubectl apply -f role-binding.yaml


# User identifier
export USER="dave"
# Cluster Name (get it from the current context)
export CLUSTER_NAME=$(kubectl config view --minify -o jsonpath={.current-context})
# Client certificate
export CLIENT_CERTIFICATE_DATA=$(kubectl get csr mycsr -o jsonpath='{.status.certificate}')
# Cluster Certificate Authority
export CLUSTER_CA=$(kubectl config view --raw -o json | jq -r '.clusters[] | select(.name == "'$(kubectl config current-context)'") | .cluster."certificate-authority-data"')
#export CLUSTER_CA=$(kubectl config view --raw -o json | jq -r '.clusters[].cluster."certificate-authority-data"')

# API Server endpoint
export CLUSTER_ENDPOINT=$(kubectl config view --raw -o json | jq -r '.clusters[] | select(.name == "'$(kubectl config current-context)'") | .cluster."server"')
#export CLUSTER_ENDPOINT=$(kubectl config view --raw -o json | jq -r '.clusters[].cluster."server"')

cat kubeconfig.tpl | envsubst > kubeconfig
