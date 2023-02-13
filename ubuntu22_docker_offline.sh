#!/bin/sh
# Version of binary chosen:
# The oldest stable release for each binary from https://download.docker.com/linux/ubuntu/dists/jammy/pool/stable/amd64/ 
# has been used below.
# https://download.docker.com/linux/ubuntu/dists/jammy/pool/stable/amd64/containerd.io_1.5.10-1_amd64.deb
# https://download.docker.com/linux/ubuntu/dists/jammy/pool/stable/amd64/docker-buildx-plugin_0.10.2-1~ubuntu.22.04~jammy_amd64.deb
# https://download.docker.com/linux/ubuntu/dists/jammy/pool/stable/amd64/docker-ce_20.10.13~3-0~ubuntu-jammy_amd64.deb
# https://download.docker.com/linux/ubuntu/dists/jammy/pool/stable/amd64/docker-ce-cli_20.10.13~3-0~ubuntu-jammy_amd64.deb
# https://download.docker.com/linux/ubuntu/dists/jammy/pool/stable/amd64/docker-compose-plugin_2.3.3~ubuntu-jammy_amd64.deb

echo "-----------Uninstalling docker if already installed--------"
sudo systemctl stop docker
sudo apt-get purge docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin docker-ce-rootless-extras
sudo rm -rf /var/lib/docker
sudo rm -rf /var/lib/containerd

echo "------------Starting docker offline install-----------------"

distro=`lsb_release -i |cut -f2`
version=`lsb_release -r |cut -f2`

if [ "$distro" != "Ubuntu" ] && [ "$version" == "22.04" ]; then
    echo "Current system is $distro $version"
    echo "OS not Ubuntuv22.04.Exiting......!"
    exit 1
fi

echo "Current OS good to proceed!"

sudo dpkg -i ./docker-binaries/containerd.io_1.5.10-1_amd64.deb \
  ./docker-binaries/docker-ce_20.10.13~3-0~ubuntu-jammy_amd64.deb \
  ./docker-binaries/docker-ce-cli_20.10.13~3-0~ubuntu-jammy_amd64.deb \
  ./docker-binaries/docker-buildx-plugin_0.10.2-1~ubuntu.22.04~jammy_amd64.deb \
  ./docker-binaries/docker-compose-plugin_2.3.3~ubuntu-jammy_amd64.deb


sudo getent group docker || groupadd docker
echo "Created group docker"
sudo usermod -aG docker $USER
echo "Added current user to group docker"

echo " =============Docker Version =========="
echo "$(docker version)"
echo " ======================================"
echo "Docker install success!"

echo "Reevaluating Group membership and starting Docker Service..."
newgrp docker

sudo service docker start