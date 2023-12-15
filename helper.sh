#!/bin/bash

config=$(linode-cli lke clusters-list --text --no-header | awk '{print $1}')
cat $config >> ~/.kube/config.lke
nb=$(for vol in $(linode-cli volumes list --text --no-header | awk '{print $1}'); do
linode-cli nodebalancers delete $nb
linode-cli volumes delete $vol
done)
lke=$(linode-cli lke clusters-list --text --no-header | awk '{print $1}')
linode-cli lke cluster-delete $lke
vol=$(linode-cli volumes list --text --no-header | awk '{print $1}')
linode-cli volumes delete $vol
export KUBECONFIG=~/.kube/config.lke

#!/bin/bash
set -e
command -v linode-cli >/dev/null 2>&1 || { echo >&2 "linode-cli ist nicht installiert.  Abbruch."; exit 1; }
command -v base64 >/dev/null 2>&1 || { echo >&2 "base64 ist nicht installiert.  Abbruch."; exit 1; }

configid=$(linode-cli lke clusters-list --text --no-header | awk '{print $1}')
config=$(linode-cli lke kubeconfig-view $configid --text --no-headers | base64 -d)

# Verwenden einer temporären Datei
tempfile=$(mktemp)
echo "$config" > $tempfile
export KUBECONFIG=$tempfile