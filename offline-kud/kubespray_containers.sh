#!/bin/bash

if [ -d "~/akraino/bpa/kubespray_containers" ]
then
    echo "Dir exists ... continue"
else
    mkdir -p ~/akraino/bpa/kubespray_containers
fi


function _get_containers {

#Getting relevant containers here.
dest_dir=~/akraino/bpa/kubespray_containers
wget -nc -P $dest_dir https://github.com/coredns/coredns/releases/download/v1.2.6/coredns_1.2.6_darwin_amd64.tgz
wget -nc -P $dest_dir http://nginx.org/download/nginx-1.14.2.tar.gz
wget -nc -P $dest_dir https://github.com/kubernetes-incubator/cluster-proportional-autoscaler/archive/1.3.0.tar.gz
wget -nc -P $dest_dir https://github.com/kubernetes/dashboard/archive/v1.10.0.tar.gz
wget -nc -P $dest_dir https://github.com/etcd-io/etcd/releases/download/v3.2.25/etcd-v3.2.25-linux-amd64.tar.gz
wget -nc -P $dest_dir https://github.com/coreos/flannel-cni/archive/v0.3.0.tar.gz
wget -nc -P $dest_dir https://get.helm.sh/helm-v2.11.0-linux-amd64.tar.gz
wget -nc -P $dest_dir https://github.com/coreos/flannel/releases/download/v0.10.0/flannel-v0.10.0-linux-amd64.tar.gz

}

_get_containers
