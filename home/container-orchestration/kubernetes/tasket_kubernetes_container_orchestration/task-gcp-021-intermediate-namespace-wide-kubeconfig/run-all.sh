#!/usr/bin/env bash

clusterNamespaceSet="default|kube-system"
userSet="groupQA|groupDEV"
accessTypeValueSet="R|RW"
FOLDER_DEV_CLUSTER="dev"


echoUsageDEVCluster()
{
    echo "Values for <namespace> : $clusterNamespaceSet"
    echo "Values for <user-group> : $userSet"
    echo "Values for <access-type> : $accessTypeValueSet"
}

assignVars()
{
  FOLDER_NAMESPACE="$1"
  FOLDER_USER_GROUP="$2"
  ACCESS_TYPE="$3"
}

generate()
{
  echo "-------------------------------"
  echo "          Resetting previous changes           "
  echo "-------------------------------"
  ./reset.sh $FOLDER_NAMESPACE $FOLDER_USER_GROUP $KUBCONFIG_CLUSTER_FOLDER

  echo "-------------------------------"
  echo "          Client Cert Generation           "
  echo "-------------------------------"
  ./client-run.sh $FOLDER_NAMESPACE $FOLDER_USER_GROUP $ACCESS_TYPE $KUBCONFIG_CLUSTER_FOLDER

  echo "-------------------------------"
  echo "          kubeconfig & dave.key generation          "
  echo "-------------------------------"
  ./admin-run.sh $FOLDER_NAMESPACE $FOLDER_USER_GROUP $ACCESS_TYPE $KUBCONFIG_CLUSTER_FOLDER
  echo "-------------------------------"
  echo "          Share the following files with the $FOLDER_USER_GROUP
          ./$KUBCONFIG_CLUSTER_FOLDER/$FOLDER_NAMESPACE/$FOLDER_USER_GROUP/kubeconfig
          ./$KUBCONFIG_CLUSTER_FOLDER/$FOLDER_NAMESPACE/$FOLDER_USER_GROUP/dave.key

          Initialization Steps
          $ export KUBECONFIG=\$PWD/kubeconfig

          $ kubectl config set-credentials dave \\
            --client-key=\$PWD/dave.key \\
            --embed-certs=true
          "
  echo "-------------------------------"
}


if [ `kubectl config view --raw -o json | jq -r '.clusters[] | select(.name == "'$(kubectl config current-context)'") | .cluster."server"' | grep "https" | wc -l` == "1"  ]
then
  echo "Dev cluster"
  if [ $# -lt 3 ]
  then
    echo "Usage: ./run-all.sh <namespace> <user-group> <access-type>"
    echoUsageDEVCluster
    exit 0
  fi
  assignVars "$1" "$2" "$3"

  if [ `echo "$FOLDER_NAMESPACE" | egrep "$clusterNamespaceSet" | wc -l` == "0"  ]
  then
    echo "<namespace> value not as per standards"
    echoUsageDEVCluster
    exit 0
  fi

  if [ `echo "$FOLDER_USER_GROUP" | egrep "$userSet" | wc -l` == "0"  ]
  then
    echo "<user-group> value not as per standards"
    echoUsageDEVCluster
    exit 0
  fi

  if [ `echo "$ACCESS_TYPE" | egrep "$accessTypeValueSet" | wc -l` == "0"  ]
  then
    echo "<access-type> value not as per standards"
    echoUsageDEVCluster
    exit 0
  fi

  KUBCONFIG_CLUSTER_FOLDER=$FOLDER_DEV_CLUSTER
  generate
fi





