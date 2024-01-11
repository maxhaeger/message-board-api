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

img=$(for image in $(linode-cli images list --text --no-header | grep private | awk '{print $1}')) ; do 
    linode-cli images delete 
    done
#!/bin/bash

configid=$(linode-cli lke clusters-list --text --no-header | awk '{print $1}')
config=$(linode-cli lke kubeconfig-view $configid --text --no-headers | base64 -d)

# Verwenden einer temporären Datei
temp=/tmp/kubeconfig-cloud.yaml
echo "$config" > $temp
export KUBECONFIG=$temp
# Retrieve Argopassword
 gcloud container clusters get-credentials gke-cluster --zone europe-west3-a --project message-board-api-408908