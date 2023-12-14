#!/bin/bash
export TF_VAR_linode_token=1df91dc19a5667440497c3dd95562876fa914898b97c62886126cb68f96e24ad
config=$(linode-cli lke clusters-list --text --no-header | awk '{print $1}')
cat $config >> ~/.kube/config.lke
nb=$(for vol in $(linode-cli volumes list --text --no-header | awk '{print $1}'); do
  linode-cli volumes delete $vol
done)
linode-cli nodebalancers delete $nb
lke=$(linode-cli lke clusters-list --text --no-header | awk '{print $1}')
linode-cli lke cluster-delete $lke
vol=$(linode-cli volumes list --text --no-header | awk '{print $1}')
linode-cli volumes delete $vol
export LINODE_CLI_TOKEN=1df91dc19a5667440497c3dd95562876fa914898b97c62886126cb68f96e24ad 
export KUBECONFIG=~/.kube/config.lke

!/bin/bash
configid=$(linode-cli lke clusters-list --text --no-header | awk '{print $1}')
config=$(linode-cli lke kubeconfig-view $configid --text --no-headers | base64 -d)
echo "$config" > ~/.kube/config.lke
export KUBECONFIG=~/.kube/config.lke