#!/usr/bin/env bash

if [ $# -lt 3 ]
then
  echo "Usage: ./admin-run.sh  <user-group> <access-type> <kubeconfig-cluster-folder>"
  exit 0
fi


FOLDER_USER_GROUP=$1
ACCESS_TYPE=$2
KUBECONFIG_CLUSTER_FOLDER=$3

# Encoding the .csr file in base64
export BASE64_CSR=$(cat ./$KUBECONFIG_CLUSTER_FOLDER/$FOLDER_USER_GROUP/dave.csr | base64 | tr -d '\n')
export NAME_OF_CSR="$KUBECONFIG_CLUSTER_FOLDER-$FOLDER_USER_GROUP-$ACCESS_TYPE-csr"
# Substitution of the BASE64_CSR env variable and creation of the CertificateSigninRequest resource
cat ./common-resources/csr.yaml | envsubst > ./$KUBECONFIG_CLUSTER_FOLDER/$FOLDER_USER_GROUP/csr.yaml
cat ./common-resources/csr.yaml | envsubst | kubectl apply -f -

kubectl get csr

kubectl certificate approve $NAME_OF_CSR

kubectl get csr

kubectl get csr $NAME_OF_CSR -o jsonpath='{.status.certificate}' \
  | base64 --decode > ./$KUBECONFIG_CLUSTER_FOLDER/$FOLDER_USER_GROUP/dave.crt


if [ "$ACCESS_TYPE" == "R" ]
then
  kubectl apply -f ./$KUBECONFIG_CLUSTER_FOLDER/$FOLDER_USER_GROUP/clusterRole-readonly.yaml
fi

if [ "$ACCESS_TYPE" == "RW" ]
then
  kubectl apply -f ./$KUBECONFIG_CLUSTER_FOLDER/$FOLDER_USER_GROUP/clusterRole-readwrite.yaml
fi


kubectl apply -f ./$KUBECONFIG_CLUSTER_FOLDER/$FOLDER_USER_GROUP/clusterRole-binding.yaml


# User identifier
export USER="dave"
# Cluster Name (get it from the current context)
export CLUSTER_NAME=$(kubectl config view --minify -o jsonpath={.current-context})
# Client certificate
export CLIENT_CERTIFICATE_DATA=$(kubectl get csr $NAME_OF_CSR -o jsonpath='{.status.certificate}')
# Cluster Certificate Authority
export CLUSTER_CA=$(kubectl config view --raw -o json | jq -r '.clusters[] | select(.name == "'$(kubectl config current-context)'") | .cluster."certificate-authority-data"')
#export CLUSTER_CA=$(kubectl config view --raw -o json | jq -r '.clusters[].cluster."certificate-authority-data"')

# API Server endpoint
export CLUSTER_ENDPOINT=$(kubectl config view --raw -o json | jq -r '.clusters[] | select(.name == "'$(kubectl config current-context)'") | .cluster."server"')
#export CLUSTER_ENDPOINT=$(kubectl config view --raw -o json | jq -r '.clusters[].cluster."server"')

cat ./common-resources/kubeconfig.tpl | envsubst > ./$KUBECONFIG_CLUSTER_FOLDER/$FOLDER_USER_GROUP/kubeconfig


rm -rf ./$KUBECONFIG_CLUSTER_FOLDER/$FOLDER_USER_GROUP/csr.cnf \
./$KUBECONFIG_CLUSTER_FOLDER/$FOLDER_USER_GROUP/dave.crt \
./$KUBECONFIG_CLUSTER_FOLDER/$FOLDER_USER_GROUP/dave.csr


