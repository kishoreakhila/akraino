#!/bin/bash

for file in $(find /root/qat_driver/*.conf -type f -name "*dev*.conf"); do
       device_id=$( echo $file | cut -d '_' -f 3 | tr -cd '[[:digit:]]')
       echo $device_id
       sudo sed -i "s/\[SSL\]/\[SSL${device_id}\]/g" /root/qat_driver/a6xxvf_dev${device_id}.conf
done
