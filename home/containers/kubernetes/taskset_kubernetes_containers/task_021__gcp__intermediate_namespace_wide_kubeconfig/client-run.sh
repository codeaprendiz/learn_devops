#!/usr/bin/env bash


if [ $# -lt 4 ]
then
  echo "Usage: ./client-run.sh <namespace-folder> <user-group> <access-type> <kubeconfig-cluster-folder>"
  exit 0
fi

FOLDER_NAMESPACE=$1
FOLDER_USER_GROUP=$2
ACCESS_TYPE=$3
KUBECONFIG_CLUSTER_FOLDER=$4




mkdir -p ./$KUBECONFIG_CLUSTER_FOLDER/$FOLDER_NAMESPACE/$FOLDER_USER_GROUP/

cp -rfp ./common-resources/csr.cnf-template ./$KUBECONFIG_CLUSTER_FOLDER/$FOLDER_NAMESPACE/$FOLDER_USER_GROUP/csr.cnf
cp -rfp ./common-resources/role-binding.yaml-template ./$KUBECONFIG_CLUSTER_FOLDER/$FOLDER_NAMESPACE/$FOLDER_USER_GROUP/role-binding.yaml

if [ "$ACCESS_TYPE" == "R" ]
then
  cp -rfp ./common-resources/role-readonly.yaml-template ./$KUBECONFIG_CLUSTER_FOLDER/$FOLDER_NAMESPACE/$FOLDER_USER_GROUP/role-readonly.yaml
fi

if [ "$ACCESS_TYPE" == "RW" ]
then
  cp -rfp ./common-resources/role-readwrite.yaml-template ./$KUBECONFIG_CLUSTER_FOLDER/$FOLDER_NAMESPACE/$FOLDER_USER_GROUP/role-readwrite.yaml
fi


egrep -rl "SUBSTITUTE_GROUPNAME" ./$KUBECONFIG_CLUSTER_FOLDER/$FOLDER_NAMESPACE/$FOLDER_USER_GROUP/ | xargs sed -i  "s/SUBSTITUTE_GROUPNAME/$FOLDER_USER_GROUP/g"

egrep -rl "SUBSTITUTE_NAMESPACE" ./$KUBECONFIG_CLUSTER_FOLDER/$FOLDER_NAMESPACE/$FOLDER_USER_GROUP/ | xargs sed -i  "s/SUBSTITUTE_NAMESPACE/$FOLDER_NAMESPACE/g"

mkdir -p ./$KUBECONFIG_CLUSTER_FOLDER/$FOLDER_NAMESPACE/$FOLDER_USER_GROUP/

openssl genrsa -out ./$KUBECONFIG_CLUSTER_FOLDER/$FOLDER_NAMESPACE/$FOLDER_USER_GROUP/dave.key 4096

openssl req -config ./$KUBECONFIG_CLUSTER_FOLDER/$FOLDER_NAMESPACE/$FOLDER_USER_GROUP/csr.cnf -new -key ./$KUBECONFIG_CLUSTER_FOLDER/$FOLDER_NAMESPACE/$FOLDER_USER_GROUP/dave.key -nodes -out ./$KUBECONFIG_CLUSTER_FOLDER/$FOLDER_NAMESPACE/$FOLDER_USER_GROUP/dave.csr


