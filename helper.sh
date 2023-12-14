#!/bin/bash
export TF_VAR_linode_token=1df91dc19a5667440497c3dd95562876fa914898b97c62886126cb68f96e24ad
config=$(linode-cli lke clusters-list --text --no-header | awk '{print $1}')
cat $config >> ~/.kube/config.lke
nb=$(linode-cli nodebalancers list --text --no-header | awk '{print $1'})
linode-cli nodebalancers delete $nb
lke=$(linode-cli lke clusters-list --text --no-header | awk '{print $1}')
linode-cli lke cluster-delete $lke
vol=$(linode-cli volumes list --text --no-header | awk '{print $1}')
linode-cli volumes delete $vol
export LINODE_CLI_TOKEN=1df91dc19a5667440497c3dd95562876fa914898b97c62886126cb68f96e24ad 
export KUBECONFIG=~/.kube/config.lke