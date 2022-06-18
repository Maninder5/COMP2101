#!/bin/bash

#First we will make a script for hostname
hname=$(hostname)
echo "Hostname: $hname"

#The following script will show domain name
dname=$(hostname --fqdn)
echo "Domain name: $dname"

#Now get Operating system name and version
osnv=$(uname -vo)
echo "Operating system name and version: $osnv"

#Following script we show us ip address
ipad=$(ip a s ens33 | awk '/inet /{print$2}')
echo Ip Adrress: $ipad

#Let's get all root filesystem status
filestatus=$(df -H)
echo "All root file system:"
echo "$filestatus"
