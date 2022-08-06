#!/usr/bin/env bash


if [ $# -lt 3 ]
then
  echo "Usage: ./reset.sh <namespace> <user-group> <kubeconfig-cluster-folder>"
  exit 0
fi

FOLDER_NAMESPACE=$1
FOLDER_USER_GROUP=$2
KUBCONFIG_CLUSTER_FOLDER=$3


export NAME_OF_CSR="$FOLDER_NAMESPACE-csr"

kubectl delete csr "$NAME_OF_CSR"



if test -f "./$KUBCONFIG_CLUSTER_FOLDER/$FOLDER_NAMESPACE/$FOLDER_USER_GROUP/role-readonly.yaml"; then
    kubectl delete -f "./$KUBCONFIG_CLUSTER_FOLDER/$FOLDER_NAMESPACE/$FOLDER_USER_GROUP/role-readonly.yaml"
fi

if test -f "./$KUBCONFIG_CLUSTER_FOLDER/$FOLDER_NAMESPACE/$FOLDER_USER_GROUP/role-readwrite.yaml"; then
    kubectl delete -f "./$KUBCONFIG_CLUSTER_FOLDER/$FOLDER_NAMESPACE/$FOLDER_USER_GROUP/role-readwrite.yaml"
fi



kubectl delete -f "./$KUBCONFIG_CLUSTER_FOLDER/$FOLDER_NAMESPACE/$FOLDER_USER_GROUP/role-binding.yaml"


rm -rf ./$KUBCONFIG_CLUSTER_FOLDER/$FOLDER_NAMESPACE/$FOLDER_USER_GROUP/*




