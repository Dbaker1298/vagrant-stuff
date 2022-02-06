#!/bin/bash
#####
#
# This bash script installs latest docker-ce, kubectl and helm software on Ubuntu 20.4 Linux AMD64
#
#####

TMP_DIR="$(mktemp -d)"

########################
##     DOCKER-CE      ##
########################
sudo apt-get remove docker docker-engine docker.io containerd runc

sudo apt-get update

sudo apt-get install -y \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg-agent \
    software-properties-common

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

sudo add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"

sudo apt-get update
sudo apt-get install -y docker-ce docker-ce-cli containerd.io


########################
##      KUBECTL       ##
########################
curl -LO "https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl"
chmod +x ./kubectl
sudo mv ./kubectl /usr/local/bin/kubectl


########################
##       HELM         ##
########################
# HELM latest release (i.e. v3.4.2)
HELM_REL=$(curl -L -I -s -o /dev/null -w %{url_effective} https://github.com/helm/helm/releases/latest | cut -d "/" -f 8)
curl -L https://get.helm.sh/helm-$HELM_REL-linux-amd64.tar.gz -o $TMP_DIR/helm.tar.gz

tar xf "$TMP_DIR/helm.tar.gz" -C "$TMP_DIR"
chmod +x $TMP_DIR/linux-amd64/helm
mv $TMP_DIR/linux-amd64/helm /usr/local/bin

# Cleanup
if [[ -d "${TMP_DIR:-}" ]]; then
    rm -rf "$TMP_DIR"
fi


########################
##       MAKE         ##
########################
sudo apt install -y make
