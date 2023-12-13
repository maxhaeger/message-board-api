#!/bin/bash
# Get the kubeconfig output from Terraform
export KUBE_VAR=`terraform output kubeconfig` && echo $KUBE_VAR | base64 -di > lke-cluster-config.yaml
less lke-cluster-config.yaml >> ~/.kube/config