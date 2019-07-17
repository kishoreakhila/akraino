#!/bin/bash

echo "Binary Package manager script running..."

if [ -d "/home/otc/bpa" ]
then
    echo "Dir exits"
else
    echo "Error: bpa does not exist"
    mkdir -p ~/bpa
    echo "Folder created making the installs script run"
fi

dest_dir=/home/otc/bpa
function _get_go {
    version=1.12.4
    local tarball=go$version.linux-amd64.tar.gz
    echo "getting go .."
    wget -N -P $dest_dir https://dl.google.com/go/$tarball
}

function _get_pip {
 echo "python deps..."
 wget -N -P $dest_dir https://packages.ubuntu.com/bionic/amd64/python-dev/download
 echo "Get pip"
 #curl -sL https://bootstrap.pypa.io/get-pip.py | sudo python
}

function _get_ansible {
    echo "Get Ansible"
    #_install_pip
    echo "Fetching  deps software properties, pythong software properties"
    wget -N -P $dest_dir http://ftp.us.debian.org/debian/pool/main/s/software-properties/software-properties-common_0.96.20.2-2_all.deb
    wget -N -P $dest_dir http://mirrors.kernel.org/ubuntu/pool/main/s/software-properties/python3-software-properties_0.96.24.32.1_all.deb
    #install ansible using pip.
    echo "fetching ansible.. "
    wget -N -P $dest_dir https://releases.ansible.com/ansible/ansible-2.7.10.tar.gz
}

function _get_docker {
    echo " Fetching deps for docker: apt-https-transport, ca-certs, curl"
    wget -N -P $dest_dir http://launchpadlibrarian.net/338548407/apt-transport-https_1.5_amd64.deb
    wget -N -P $dest_dir  http://launchpadlibrarian.net/364556507/ca-certificates_20180409_all.deb
    #need to get docker version working. WIP
}

function _get_kubespray {
    echo " Fetching Kubespray..."
    wget -nc -P $dest_dir https://github.com/kubernetes-incubator/kubespray/archive/v2.8.2.tar.gz
    echo "Requirements for Kubespray..."
    wget -nc -P $dest_dir https://github.com/drkjam/netaddr/archive/netaddr-0.7.19.tar.gz
    wget -nc -P $dest_dir https://github.com/pallets/jinja/archive/2.9.6.tar.gz
    wget -nc -P $dest_dir http://archive.ubuntu.com/ubuntu/pool/main/p/python-pbr/python-pbr_3.1.1.orig.tar.xz
    #WIP hvac

}

function _get_kubespray_componenets {
   echo "Fetching componenets for Kubespray"

}
_get_go
_get_pip
_get_ansible
_get_docker
_get_kubespray
