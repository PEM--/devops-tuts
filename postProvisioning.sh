#!/bin/bash
# Install Docker Machine
#curl -L https://github.com/docker/machine/releases/download/v0.4.0/docker-machine_linux-amd64 | sudo tee /usr/local/bin/docker-machine > /dev/null
#sudo chmod u+x /usr/local/bin/docker-machine

# Install Firewall
sudo apt-get install -y ufw
yes | sudo ufw reset
# Deny everything else
sudo ufw default deny incoming
# Allow outgoing traffic (for logs, updates, ...)
sudo ufw default allow outgoing
# Allow SSH
sudo ufw allow ssh
# Allow HTTP and WS
sudo ufw allow 80/tcp
# Allow HTTPS and WSS
sudo ufw allow 443/tcp
# Allow Docker daemon port and forwarding policy
sudo ufw allow 2376/tcp
#sudo sed -i -e "s/^DEFAULT_FORWARD_POLICY=\"DROP\"/DEFAULT_FORWARD_POLICY=\"ACCEPT\"/" /etc/default/ufw
# Enable and reload
yes | sudo ufw enable
sudo ufw reload
