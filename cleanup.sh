#!/bin/bash
export LINODE_CLI_TOKEN=1df91dc19a5667440497c3dd95562876fa914898b97c62886126cb68f96e24ad

for nb in $(linode-cli nodebalancers list --text --no-header | awk '{print $1}'); do
    linode-cli nodebalancers delete $nb
done

for vol in $(linode-cli volumes list --text --no-header | awk '{print $1}'); do
    linode-cli volumes delete $vol
done

for image in $(linode-cli images list --text --no-header | grep private | awk '{print $1}') ; do 
    linode-cli images delete $image
done