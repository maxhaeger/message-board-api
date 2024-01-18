#!/bin/bash
# Get the kubeconfig output from Terraform
export KUBE_VAR=`terraform output kubeconfig` && echo $KUBE_VAR | base64 -d > lke-cluster-config.yaml
less lke-cluster-config.yaml >> ~/.kube/config