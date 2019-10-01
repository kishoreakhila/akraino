#!/bin/bash

echo "hello world"
modprobe -r iavf
# assume you copy iavf.ko to below folder
kver=`uname -a | awk '{print $3}'`
rm -rf /lib/modules/$kver/updates/drivers/net/ethernet/intel/iavf/iavf.ko
depmod -a
rm -rf /tmp/sriov
rm -rf iavf-3.7.34.tar.gz
