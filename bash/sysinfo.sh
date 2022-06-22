#!/bin/bash

#First we will make a script for hostname
hname=$(hostname)

#The following script will show domain name
dname=$(hostname --fqdn)

#Now get Operating system name and version
osnv=$(uname -vo)

#Following script we show us ip address
ipad=$(hostname -I)

#Let's get all root filesystem status
filestatus=$(df -H --total --output=avail | tail -1)

cat << EOF
Report for $hname
===============
FQDN: $dname
Operating System name and version: $osnv
IP Address: $ipad
Root Filesystem Free Space: $filestatus
===============
EOF
