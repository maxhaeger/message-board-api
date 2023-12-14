#!/bin/bash
configid=$(linode-cli lke clusters-list --text --no-header | awk '{print $1}')
config=$(linode-cli lke kubeconfig-view $configid --text --no-headers | base64 -d)
echo "$config" > ~/.kube/config.lke
export KUBECONFIG=~/.kube/config.lke