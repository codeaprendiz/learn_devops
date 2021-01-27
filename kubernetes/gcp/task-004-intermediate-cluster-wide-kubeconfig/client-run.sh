#!/usr/bin/env bash


if [ $# -lt 3 ]
then
  echo "Usage: ./client-run.sh <user-group> <access-type> <kubeconfig-cluster-folder>"
  exit 0
fi


FOLDER_USER_GROUP=$1
ACCESS_TYPE=$2
KUBECONFIG_CLUSTER_FOLDER=$3




mkdir -p ./$KUBECONFIG_CLUSTER_FOLDER/$FOLDER_USER_GROUP/

cp -rfp ./common-resources/csr.cnf-template ./$KUBECONFIG_CLUSTER_FOLDER/$FOLDER_USER_GROUP/csr.cnf
cp -rfp ./common-resources/clusterRole-binding.yaml-template ./$KUBECONFIG_CLUSTER_FOLDER/$FOLDER_USER_GROUP/clusterRole-binding.yaml

if [ "$ACCESS_TYPE" == "R" ]
then
  cp -rfp ./common-resources/clusterRole-readonly.yaml-template ./$KUBECONFIG_CLUSTER_FOLDER/$FOLDER_USER_GROUP/clusterRole-readonly.yaml
fi

if [ "$ACCESS_TYPE" == "RW" ]
then
  cp -rfp ./common-resources/clusterRole-readwrite.yaml-template ./$KUBECONFIG_CLUSTER_FOLDER/$FOLDER_USER_GROUP/clusterRole-readwrite.yaml
fi


egrep -rl "SUBSTITUTE_GROUPNAME" ./$KUBECONFIG_CLUSTER_FOLDER/$FOLDER_USER_GROUP/ | xargs sed -i  "s/SUBSTITUTE_GROUPNAME/$FOLDER_USER_GROUP/g"

egrep -rl "SUBSTITUTE_CLUSTER_NAME" ./$KUBECONFIG_CLUSTER_FOLDER/$FOLDER_USER_GROUP/ | xargs sed -i  "s/SUBSTITUTE_CLUSTER_NAME/$KUBECONFIG_CLUSTER_FOLDER/g"

egrep -rl "SUBSTITUTE_ACCESS_TYPE" ./$KUBECONFIG_CLUSTER_FOLDER/$FOLDER_USER_GROUP/ | xargs sed -i  "s/SUBSTITUTE_ACCESS_TYPE/$ACCESS_TYPE/g"

mkdir -p ./$KUBECONFIG_CLUSTER_FOLDER/$FOLDER_USER_GROUP/

openssl genrsa -out ./$KUBECONFIG_CLUSTER_FOLDER/$FOLDER_USER_GROUP/dave.key 4096

openssl req -config ./$KUBECONFIG_CLUSTER_FOLDER/$FOLDER_USER_GROUP/csr.cnf -new -key ./$KUBECONFIG_CLUSTER_FOLDER/$FOLDER_USER_GROUP/dave.key -nodes -out ./$KUBECONFIG_CLUSTER_FOLDER/$FOLDER_USER_GROUP/dave.csr


