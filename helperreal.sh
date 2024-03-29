configid=$(linode-cli lke clusters-list --text --no-header | awk '{print $1}')
config=$(linode-cli lke kubeconfig-view $configid --text --no-headers | base64 -d)
echo "$config" > /tmp/kubeconfig.yaml
export KUBECONFIG=$(echo /tmp/kubeconfig.yaml)