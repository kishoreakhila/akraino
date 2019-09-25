#!/bin/bash

echo " Hello world..."
ethernet_adpator_version=$( lspci | grep "Ethernet Controller X710" | head -n 1 | cut -d " " -f 8 )
echo "Here : " $ethernet_adpator_version
