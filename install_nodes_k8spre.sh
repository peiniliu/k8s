#!/bin/bash

# Update the system
sudo apt-get update -y && sudo apt-get upgrade -y

# Disable Swap
sudo swapoff -a
sudo sed -i '/ swap / s/^\(.*\)$/#\1/g' /etc/fstab

# Install necessary packages
sudo apt-get install -y apt-transport-https ca-certificates curl

# Add Kubernetes APT repository
curl -fsSL https://pkgs.k8s.io/core:/stable:/v1.28/deb/Release.key | sudo gpg --dearmor -o /etc/apt/keyrings/kubernetes-apt-keyring.gpg
sudo chmod 644 /etc/apt/keyrings/kubernetes-apt-keyring.gpg
echo 'deb [signed-by=/etc/apt/keyrings/kubernetes-apt-keyring.gpg] https://pkgs.k8s.io/core:/stable:/v1.28/deb/ /' | sudo tee /etc/apt/sources.list.d/kubernetes.list
sudo chmod 644 /etc/apt/sources.list.d/kubernetes.list

# Update package list
sudo apt-get update -y

# Install Kubernetes components
sudo apt-get install -y kubelet kubeadm kubectl

# Hold the packages at their current version
sudo apt-mark hold kubelet kubeadm kubectl

#other settings
sudo tee /etc/sysctl.d/k8s.conf <<EOF
net.bridge.bridge-nf-call-ip6tables = 1
net.bridge.bridge-nf-call-iptables = 1
net.ipv4.ip_forward = 1
EOF

sudo modprobe br_netfilter
echo 'br_netfilter' | sudo tee /etc/modules-load.d/br_netfilter.conf

sudo sysctl --system

sudo sysctl net.bridge.bridge-nf-call-iptables
sudo sysctl net.ipv4.ip_forward


sudo ufw disable
