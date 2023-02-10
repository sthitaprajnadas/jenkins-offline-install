

Go to https://download.docker.com/linux/ubuntu/dists/.

Select your Ubuntu version in the list.

Go to pool/stable/ and select the applicable architecture (amd64, armhf, arm64, or s390x).

Download the following deb files for the Docker Engine, CLI, containerd, and Docker Compose packages:

    containerd.io_<version>_<arch>.deb
    docker-ce_<version>_<arch>.deb
    docker-ce-cli_<version>_<arch>.deb
    docker-buildx-plugin_<version>_<arch>.deb
    docker-compose-plugin_<version>_<arch>.deb

Install the .deb packages. Update the paths in the following example to where you downloaded the Docker packages.

 sudo dpkg -i ./docker-binaries/containerd.io_<version>_<arch>.deb \
  ./docker-binaries/docker-ce_<version>_<arch>.deb \
  ./docker-binaries/docker-ce-cli_<version>_<arch>.deb \
  ./docker-binaries/docker-buildx-plugin_<version>_<arch>.deb \
  ./docker-binaries/docker-compose-plugin_<version>_<arch>.deb

The Docker daemon starts automatically.

Verify that the Docker Engine installation is successful by running the hello-world image:

 sudo service docker start

 sudo docker run hello-world