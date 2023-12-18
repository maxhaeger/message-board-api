#!/bin/bash
for nb in $(linode-cli nodebalancers list --text --no-header | awk '{print $1}'); do
    linode-cli nodebalancers delete $nb
done

for vol in $(linode-cli volumes list --text --no-header | awk '{print $1}'); do
    linode-cli volumes delete $vol
done

for image in $(linode-cli images list --text --no-header | grep private | awk '{print $1}') ; do 
    linode-cli images delete $image
done