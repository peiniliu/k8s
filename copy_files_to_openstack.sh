#!/bin/bash

# List of servers
servers=("k8s-master" "k8s-node1" "k8s-node2")

# List of files to be copied
files=(
    "/home/pliu/platform/k8s_1.28.2/install_nodes_k8spre.sh"
    "/home/pliu/platform/k8s_1.28.2/install_config_containerd.sh"
)

# Destination directory
destination="~/"

# Loop through each server and use scp
for server in "${servers[@]}"; do
  for file in "${files[@]}"; do
    scp "$file" "$server:$destination"
  done
done
