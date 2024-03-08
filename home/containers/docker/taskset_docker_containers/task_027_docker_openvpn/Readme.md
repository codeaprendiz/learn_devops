# OpenVPN

[github.com » kylemanna/docker-openvpn (last commit around 4 years back)](https://github.com/kylemanna/docker-openvpn)

[digitalocean.com » How To Run OpenVPN in a Docker Container on Ubuntu 14.04](https://www.digitalocean.com/community/tutorials/how-to-run-openvpn-in-a-docker-container-on-ubuntu-14-04)

## Install via script

```bash
sudo bash setup_vpn.sh
```

## Openvpn steps (Install manually)

### System settings

```bash
# Displays the current status of IP forwarding for IPv4.
sysctl net.ipv4.ip_forward

# Enables IP forwarding for IPv4. This change is temporary and will be lost after a reboot.
sudo sysctl -w net.ipv4.ip_forward=1

# Displays the current value of the lowest unprivileged port number that can be used by non-root users.
sudo sysctl net.ipv4.ip_unprivileged_port_start

# Sets the lowest unprivileged port number to 443, allowing non-root users to bind to ports 443 and above. This requires superuser privileges and the change is temporary, lost after a reboot.
sudo sysctl -w net.ipv4.ip_unprivileged_port_start=443
```

### [Install Docker](https://docs.docker.com/engine/install/ubuntu)

```bash
# Add Docker's official GPG key:
sudo apt-get update
sudo apt-get install ca-certificates curl gnupg
sudo install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
sudo chmod a+r /etc/apt/keyrings/docker.gpg

# Add the repository to Apt sources:
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update

sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
```

### Install VPN

```bash
# Go sudo
sudo su

# Set an environment variable OVPN_DATA to be used as the name for a Docker volume that will store OpenVPN configuration and data.
export OVPN_DATA=ovpn-data

# Create a Docker volume named after the value of OVPN_DATA to persist OpenVPN configuration and data across container restarts.
docker volume create $OVPN_DATA

# Get public IP of instance
PUBLIC_IP_OF_THE_SERVER_INSTANCE=$(curl -s ifconfig.me)
# Run a temporary Docker container with the OpenVPN image to generate OpenVPN server configuration files, specifying the server's public IP and the protocol and port to use (replace <PUBLIC_IP_OF_THE_SERVER_INSTANCE> with the actual IP).
docker run -v $OVPN_DATA:/etc/openvpn -it --rm kylemanna/openvpn ovpn_genconfig -u tcp://$PUBLIC_IP_OF_THE_SERVER_INSTANCE:443

# Run a temporary Docker container with the OpenVPN image to initialize the Public Key Infrastructure (PKI) for OpenVPN without a passphrase for the CA key (for ease of automated start without manual intervention).
# When prompted : Common Name (eg: your user, host, or server name) [Easy-RSA CA]: : press Enter, OR setting up a personal VPN, you can keep it simple, like "MyVPN CA"
docker run -v $OVPN_DATA:/etc/openvpn -it --rm kylemanna/openvpn ovpn_initpki nopass

# Run a Docker container in detached mode with privileged access and configure it to restart automatically on failure or reboot. It binds port 443 on the host to port 1194 on the container, which is the standard OpenVPN port, but using TCP. The container uses the volume specified by OVPN_DATA to persist configuration data.
docker run --privileged --detach --name openvpn --restart always --publish 443:1194/tcp --volume $OVPN_DATA:/etc/openvpn kylemanna/openvpn
```

## Create profiles using openvpn

```bash
# export SSH_SERVER=ubuntu@<public_instance_jip>


# Run a temporary Docker container with the OpenVPN image to generate a client certificate and key pair named "client-laptop" without a passphrase.
# This operation utilizes the easyrsa tool included in the OpenVPN image to create the necessary files for a new VPN client named "client-laptop".
# The "--rm" option ensures that the container is removed after the command completes, and the certificate and keys are stored in the persistent volume named by OVPN_DATA.
sudo docker run -v $OVPN_DATA:/etc/openvpn --rm kylemanna/openvpn easyrsa build-client-full client-laptop nopass
```

## Download the profile locally for openvpn

```bash
# Run a temporary Docker container with the OpenVPN image to export the configuration for the VPN client named "client-laptop".
# This command retrieves the complete client configuration and certificates necessary for a VPN connection, formatted as an .ovpn file.
# The output from this command should be manually copied and saved on the client device as "client-personal.ovpn".
sudo docker run -v $OVPN_DATA:/etc/openvpn --rm kylemanna/openvpn ovpn_getclient client-laptop
```

## Download and install OpenVPN client

[mac os openvpn client](https://openvpn.net/client-connect-vpn-for-mac-os)

- Open the OpenVPN client and import the file `client-personal.ovpn` and connect

```bash
# Validate your public IP is the IP of the VPN server
curl ifconfig.me
```

## Revoke the profile from openvpn

```bash
# You will have to confirm : yes
sudo docker run -v $OVPN_DATA:/etc/openvpn --rm -i kylemanna/openvpn ovpn_revokeclient client-laptop
```

## list the profiles

```bash
# To print the list of profiles
sudo docker run -v $OVPN_DATA:/etc/openvpn --rm kylemanna/openvpn ovpn_listclients
```
