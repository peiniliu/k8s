#!/bin/bash

#container runtime containerd

# Initialize Kubernetes cluster
sudo kubeadm init --config k8s-config.yaml

# Set up local kubeconfig
mkdir -p $HOME/.kube
sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config

kubectl apply -f kube-flannel.yml

# Allow master node to schedule pods (necessary for single-node setup)
kubectl taint nodes --all node-role.kubernetes.io/control-plane-

echo "Kubernetes 1.28.2 installation is complete."

