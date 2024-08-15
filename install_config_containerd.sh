# Step 3: Install containerd
echo "Updating package index and installing containerd..."
sudo apt-get update -y
sudo apt-get install -y containerd

# Step 4: Configure containerd to use systemd as the cgroup driver
echo "Configuring containerd to use systemd as the cgroup driver..."

# Create containerd config directory if it doesn't exist
sudo mkdir -p /etc/containerd

# Generate default containerd configuration and modify it
sudo containerd config default | sudo tee /etc/containerd/config.toml

# Set SystemdCgroup = true in containerd config
sudo sed -i 's/SystemdCgroup = false/SystemdCgroup = true/' /etc/containerd/config.toml
sudo sed -i 's#sandbox_image = "registry.k8s.io/pause:3.8"#sandbox_image = "registry.k8s.io/pause:3.9"#' /etc/containerd/config.toml

# Step 5: Restart containerd to apply the changes
echo "Restarting containerd service..."
sudo systemctl restart containerd

# Step 6: Verify containerd installation and cgroup driver
echo "Verifying containerd status and cgroup driver..."
sudo systemctl status containerd --no-pager

# Optional: Verify cgroup driver using crictl
if command -v crictl &> /dev/null; then
  crictl info | grep "systemd"
else
  echo "crictl not installed; skipping cgroup driver verification with crictl."
fi

echo "Containerd installation and configuration complete."
