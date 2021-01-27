#!/usr/bin/env bash



kubectl delete csr mycsr


kubectl delete -f role.yaml

kubectl delete -f role-binding.yaml

kubectl delete -f dev-ns.yaml


rm -rf kubeconfig dave.crt dave.csr dave.key
