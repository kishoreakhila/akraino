#!/bin/bash

echo "Hello world"

sudo apt-get install docker-ce=18.06.1~ce~3-0~ubuntu containerd.io

function _configure docker {
    local max_concurrent_downloads=${1:-3}
    fqdn=$(hostname -A)
    fqdn="${fqdn%"${fqdn##*[![:space:]]}"}"
    sudo mkdir -p /etc/systemd/system/docker.service.d
    if [ ${http_proxy:-} ]; then
        echo "[Service]" | sudo tee /etc/systemd/system/docker.service.d/http-proxy.conf
        echo "Environment=\"HTTP_PROXY=$http_proxy\"" | sudo tee --append /etc/systemd/system/docker.service.d/http-proxy.conf
    fi
    if [ ${https_proxy:-} ]; then
        echo "[Service]" | sudo tee /etc/systemd/system/docker.service.d/https-proxy.conf
        echo "Environment=\"HTTPS_PROXY=$https_proxy\"" | sudo tee --append /etc/systemd/system/docker.service.d/https-proxy.conf
    fi
    if [ ${no_proxy:-} ]; then
        echo "[Service]" | sudo tee /etc/systemd/system/docker.service.d/no-proxy.conf
        echo "Environment=\"NO_PROXY=$no_proxy\"" | sudo tee --append /etc/systemd/system/docker.service.d/no-proxy.conf
    fi
    sudo systemctl daemon-reload

    echo "Ak_OPTS=\" --insecure-registry=$fqdn:5000 --max-concurrent-downloads $max_concurrent_downloads \"" | sudo tee --append /etc/default/docker
    if [[ -z $(groups | grep docker) ]]; then
        sudo usermod -aG docker $USER
    fi

    sudo systemctl restart docker


}
