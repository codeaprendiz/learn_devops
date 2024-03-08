#!/bin/bash

# Last run on : Ubuntu 22.04 LTS, 7 Mar 2024

# Script to set up OpenVPN on a server using Docker
sudo apt-get update 
sudo apt-get install -y ca-certificates curl gnupg 
sudo install -m 0755 -d /etc/apt/keyrings 
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg 
sudo chmod a+r /etc/apt/keyrings/docker.gpg 
echo \
"deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
$(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
# Install Docker Engine, CLI, and additional plugins
sudo apt-get update 
sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin 

# Configure system settings for OpenVPN
echo "Configuring system settings for OpenVPN..."
sudo sysctl -w net.ipv4.ip_forward=1 
sudo sysctl -w net.ipv4.ip_unprivileged_port_start=443 

# Set up OpenVPN
echo "Setting up OpenVPN..."
export OVPN_DATA=ovpn-data
docker volume create $OVPN_DATA

# Obtain the public IP of the server
PUBLIC_IP_OF_THE_SERVER_INSTANCE=$(curl -s ifconfig.me)

docker run -v $OVPN_DATA:/etc/openvpn -it --rm kylemanna/openvpn ovpn_genconfig -u tcp://$PUBLIC_IP_OF_THE_SERVER_INSTANCE:443
docker run -v $OVPN_DATA:/etc/openvpn -it --rm kylemanna/openvpn ovpn_initpki nopass
docker run --privileged --detach --name openvpn --restart always --publish 443:1194/tcp --volume $OVPN_DATA:/etc/openvpn kylemanna/openvpn
sudo docker run -v $OVPN_DATA:/etc/openvpn --rm kylemanna/openvpn easyrsa build-client-full client-laptop nopass

# Output command to retrieve the client configuration
echo "Run the following command to output the client configuration:"
echo "sudo docker run -v $OVPN_DATA:/etc/openvpn --rm kylemanna/openvpn ovpn_getclient client-laptop"
