#!/bin/bash
configid=$(linode-cli lke clusters-list --text --no-header | awk '{print $1}')
config=$(linode-cli lke kubeconfig-view $configid --text --no-headers | base64 -d)

# Verwenden einer temporären Datei anstelle einer Datei im Home-Verzeichnis
tempfile=$(mktemp)
echo "$config" > $tempfile
export KUBECONFIG=$tempfile
