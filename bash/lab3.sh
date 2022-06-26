#! /bin/bash

# Checking if lxd is installed
if  [ -x "$(command -v lxd)" ]; then
    echo 'lxd is already installed!'
else
    echo 'lxd is not installed. Installing it now!'
    sudo snap install lxd
fi

# Check if lxdbr0 interface exists
ip a show lxdbr0 &>/dev/null && 
    echo "lxdbr0 interface exists" || 
    { 
        echo "No lxdbr0 interface. Setting it up"; 
        sudo lxd init --auto; 
    }

# Checking if COMP2101-S22 container exists
sudo lxc list -c n | grep COMP2101-S22 &>/dev/null && 
    echo "COMP2101-S22 Container exists" || 
    { 
        echo "Launching COMP2101-S22 container"; 
        sudo lxc launch images:ubuntu/focal/amd64 COMP2101-S22; 
        sudo lxc start COMP2101-S22; 
    }


# Adding container hostname and IP address to /etc/hosts
ip_address=`sudo lxc list -c n4 | grep COMP2101-S22 | awk '{print $4}'`
sudo sed -i "/COMP2101-S22/ { c \
$ip_address COMP2101-S22
}"  /etc/hosts
echo "Added container hostname and IP Address to hostfile"; 

# Checking if Apache2 is installed
sudo lxc exec COMP2101-S22 -- bash -c 'if [ -x "$(command -v apache2)" ]; then
  echo "Apache is already installed"
else
  echo "Apache is not installed. Installing it now!";
  sudo sudo apt-get update && apt-get -y install apache2;
fi
'

# Fetch web page
curl http://COMP2101-S22  &>/dev/null && echo "Success, homepage fetched." || echo "Failed to get homepage."
