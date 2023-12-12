#!/bin/bash
export TF_VAR_linode_token=1df91dc19a5667440497c3dd95562876fa914898b97c62886126cb68f96e24ad
cd terraform && terraform init && terraform apply -auto-approve
sleep 60 -m "Waiting for Nodes to be ready"
bash import-kubeconfig.sh
sleep 5 -m "Waiting for Kubeconfig to be set"
cd ../helm && helm install backend ./backend && helm install frontend ./frontend && helm install environment ./environment
sleep 60 -m "Waiting for Pods to be ready"
kubectl apply -f https://bit.ly/ingress_nginx_1_2_0