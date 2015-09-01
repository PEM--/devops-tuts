#!/bin/bash
# Overriding bad Systemd default in Docker startup script
sudo mkdir -p /etc/systemd/system/docker.service.d
echo -e '[Service]\n# workaround to include default options\nEnvironmentFile=-/etc/default/docker\nExecStart=\nExecStart=/usr/bin/docker -d -H fd:// $DOCKER_OPTS' | sudo tee /etc/systemd/system/docker.service.d/ubuntu.conf
# Set Docker daemon with the following properties:
# * Daemon listen to external request and is exposed on port 2376, the default Docker port.
# * Docker uses the AUFS driver for file storage.
# * Daemon uses Docker's provided certification chain.
# * Dameon has a generic label.
# * Daemon is able to resolve DNS query using Google's DNS.
echo 'DOCKER_OPTS="-H tcp://0.0.0.0:2376 -H unix:///var/run/docker.sock --storage-driver aufs --tlsverify --tlscacert /etc/docker/ca.pem --tlscert /etc/docker/server.pem --tlskey /etc/docker/server-key.pem --label provider=generic --dns 8.8.8.8 --dns 8.8.4.4"'  | sudo tee /etc/default/docker
sudo systemctl daemon-reload
sudo systemctl restart docker
# Enable Docker on server reboot
sudo systemctl enable docker
# Remove and clean unused packages
sudo apt-get autoremove -y
sudo apt-get autoclean -y
