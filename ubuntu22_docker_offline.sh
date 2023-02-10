#!/bin/sh
# Version of binary chosen:
# The oldest stable release for each binary from https://download.docker.com/linux/ubuntu/dists/jammy/pool/stable/amd64/ 
# has been used below.
# https://download.docker.com/linux/ubuntu/dists/jammy/pool/stable/amd64/containerd.io_1.5.10-1_amd64.deb
# https://download.docker.com/linux/ubuntu/dists/jammy/pool/stable/amd64/docker-buildx-plugin_0.10.2-1~ubuntu.22.04~jammy_amd64.deb
# https://download.docker.com/linux/ubuntu/dists/jammy/pool/stable/amd64/docker-ce_20.10.13~3-0~ubuntu-jammy_amd64.deb
# https://download.docker.com/linux/ubuntu/dists/jammy/pool/stable/amd64/docker-ce-cli_20.10.13~3-0~ubuntu-jammy_amd64.deb
# https://download.docker.com/linux/ubuntu/dists/jammy/pool/stable/amd64/docker-compose-plugin_2.3.3~ubuntu-jammy_amd64.deb

echo "starting docker offline install"

distro=`lsb_release -i |cut -f2`
version=`lsb_release -r |cut -f2`

if [ "$distro" != "Ubuntu" && "$version" == "v22.04"]; then
    echo "Current system is $distro $version"
    echo "OS not Ubuntuv22.04.Exiting......!"
    exit 1
fi

sudo dpkg -i ./docker-binaries/containerd.io_1.5.10-1_amd64.deb \
  ./docker-binaries/docker-ce_20.10.13~3-0~ubuntu-jammy_amd64.deb \
  ./docker-binaries/docker-ce-cli_20.10.13~3-0~ubuntu-jammy_amd64.deb \
  ./docker-binaries/docker-buildx-plugin_0.10.2-1~ubuntu.22.04~jammy_amd64.deb \
  ./docker-binaries/docker-compose-plugin_2.3.3~ubuntu-jammy_amd64.deb

sudo service docker start

echo "$(docker version)"

echo "Docker install success!"