#!/bin/bash

#max_concurrent_downloads=${1:-3}
#fqdn=$(hostname -A)
#fqdn="${fqdn%"${fqdn##*[![:space:]]}"}"
#echo "Akhila_OPTS=\" --insecure-registry=$fqdn:5000 --max-concurrent-downloads $max_concurrent_downloads \"" | sudo tee --append /etc/environment

FILE=~/akhila.json

if [ -f $FILE ]
then
   rm $FILE
   cat > akhila.json <<EOF
   {"insecure-registries":["myregistrydomain.com:5000"]}
EOF
else
   cat > akhila.json <<EOF
   {"insecure-registries":["akhila.com:5000"]}
EOF
fi
