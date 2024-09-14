# [Bridge Network Tutorial](https://docs.docker.com/engine/network/tutorials/standalone/)

- [Bridge Network Tutorial](#bridge-network-tutorial)
  - [Networking with standalone containers](#networking-with-standalone-containers)
    - [Use the default bridge network](#use-the-default-bridge-network)
    - [Use user-defined bridge networks](#use-user-defined-bridge-networks)

## Networking with standalone containers

### [Use the default bridge network](https://docs.docker.com/engine/network/tutorials/standalone/#use-the-default-bridge-network)

Check the existing networks on your Docker host.

```bash
docker network ls
```

Output

```bash
NETWORK ID          NAME                DRIVER              SCOPE
17e324f45964        bridge              bridge              local
6ed54d316334        host                host                local
7092879f2cc8        none                null                local
```

Run two containers using the default bridge network.

```bash
docker run -dit --name alpine1 alpine ash

docker run -dit --name alpine2 alpine ash
```

```bash
docker container ls
```

Validate that the containers are part of the default bridge network.

```bash
docker network inspect bridge | jq '.[0].IPAM.Config'
```

Output shows the default subnet and gateway for the bridge network.

```json
[
  {
    "Subnet": "172.17.0.0/16",
    "Gateway": "172.17.0.1"
  }
]
```

List the containers connected to the bridge network along with their IP addresses.

```bash
docker network inspect bridge | jq '.[0].Containers | to_entries[] | {Name: .value.Name, IPv4Address: .value.IPv4Address}'
```

Output

```json
{
  "Name": "alpine1",
  "IPv4Address": "172.17.0.2/16"
}
{
  "Name": "alpine2",
  "IPv4Address": "172.17.0.3/16"
}
```

Near the top, information about the bridge network is listed, including the IP address of the gateway between the Docker host and the bridge network (172.17.0.1). Under the Containers key, each connected container is listed, along with information about its IP address (172.17.0.2 for alpine1 and 172.17.0.3 for alpine2)

Use the docker attach command to connect to alpine1.

```bash
docker attach alpine1
```

From within alpine1, check the interface configuration using the ip addr show command.

```bash
/ # ip addr show | grep -A 4 18
18: eth0@if19: <BROADCAST,MULTICAST,UP,LOWER_UP,M-DOWN> mtu 65535 qdisc noqueue state UP 
    link/ether xxxxxxxxx brd ff:ff:ff:ff:ff:ff
    inet 172.17.0.2/16 brd 172.17.255.255 scope global eth0
       valid_lft forever preferred_lft forever
```

Notice that the second interface has the IP address 172.17.0.2, which is the same address shown for alpine1 in the previous step.

From within alpine1, make sure you can connect to the internet by pinging google.com

```bash
ping -c 2 google.com
```

Output

```bash
...output omitted...
--- google.com ping statistics ---
2 packets transmitted, 2 packets received, 0% packet loss
```

Now try to ping the second container. First, ping it by its IP address, 172.17.0.3:

```bash
ping -c 2 172.17.0.3
```

Output

```bash
...output omitted...
--- 172.17.0.3 ping statistics ---
2 packets transmitted, 2 packets received, 0% packet loss
```

try pinging the alpine2 container by container name. This will fail.

```bash
ping -c 2 alpine2
```

Output

```bash
ping: bad address 'alpine2'
```

Stop and remove both containers.

```bash
docker container stop alpine1 alpine2
docker container rm alpine1 alpine2
```

### [Use user-defined bridge networks](https://docs.docker.com/engine/network/tutorials/standalone/#use-user-defined-bridge-networks)

Create the `alpine-net` network. You do not need the `--driver bridge` flag since it's the default, but this example shows how to specify it.

```bash
docker network create --driver bridge alpine-net
```

Check the existing networks on your Docker host.

```bash
docker network ls
```

Output

```bash
NETWORK ID     NAME         DRIVER    SCOPE
8eb10931dafa   alpine-net   bridge    local
9c07ae548da7   bridge       bridge    local
8090aebebfd2   host         host      local
237022f0a976   none         null      local
```

Inspect the `alpine-net` network.

```bash
docker network inspect alpine-net | jq '.[0].IPAM.Config'
```

Output shows the default subnet and gateway for the `alpine-net` network.

```json
[
  {
    "Subnet": "172.18.0.0/16",
    "Gateway": "172.18.0.1"
  }
]
```

Notice that this network's gateway is `172.18.0.1`, as opposed to the default bridge network, whose gateway is `172.17.0.1`. 

Create your four containers. Notice the `--network` flags. You can only connect to one network during the docker run command, so you need to use `docker network connect` afterward to connect `alpine4` to the bridge network as well.

```bash
 docker run -dit --name alpine1 --network alpine-net alpine ash

 docker run -dit --name alpine2 --network alpine-net alpine ash

 docker run -dit --name alpine3 alpine ash

 docker run -dit --name alpine4 --network alpine-net alpine ash
```

```bash
 docker network connect bridge alpine4
```

List containers connected to the `alpine-net` network along with their IP addresses.

```bash
docker network inspect alpine-net | jq '.[0].Containers | to_entries[] | {Name: .value.Name, IPv4Address: .value.IPv4Address}'
```

Output

```bash
{
  "Name": "alpine2",
  "IPv4Address": "172.18.0.3/16"
}
{
  "Name": "alpine1",
  "IPv4Address": "172.18.0.2/16"
}
{
  "Name": "alpine4",
  "IPv4Address": "172.18.0.4/16"
}
```

List containers connected to the bridge network along with their IP addresses.

```bash
docker network inspect bridge | jq '.[0].Containers | to_entries[] | {Name: .value.Name, IPv4Address: .value.IPv4Address}'
```

Output

```bash
{
  "Name": "alpine3",
  "IPv4Address": "172.17.0.2/16"
}
{
  "Name": "alpine4",
  "IPv4Address": "172.17.0.3/16"
}
```

- On user-defined networks like alpine-net, containers can not only communicate by IP address, but can also resolve a container name to an IP address. This capability is called automatic `service discovery`.
- Let's connect to alpine1 and test this out. alpine1 should be able to resolve alpine2 and alpine4 (and alpine1, itself) to IP addresses.

```bash
docker attach alpine1
```

```bash
#----------- Ping alpine1
/ # ping -c 1 alpine2
...output omitted...
--- alpine2 ping statistics ---
1 packets transmitted, 1 packets received, 0% packet loss

#----------- Ping alpine4
/ # ping -c 1 alpine4
PING alpine4 (172.18.0.4): 56 data bytes
64 bytes from 172.18.0.4: seq=0 ttl=64 time=0.127 ms

--- alpine4 ping statistics ---
1 packets transmitted, 1 packets received, 0% packet loss

#-----------  Ping the IP address of alpine4
/ # ping -c 1 172.18.0.4
PING 172.18.0.4 (172.18.0.4): 56 data bytes
64 bytes from 172.18.0.4: seq=0 ttl=64 time=0.109 ms

--- 172.18.0.4 ping statistics ---
1 packets transmitted, 1 packets received, 0% packet loss

#----------- Ping alpine3
/ # ping -c 1 alpine3, # because alpine3 is not on the alpine-net network
ping: bad address 'alpine3'

/ # ping -c 1 172.17.0.2 # alpine3's IP address, because it's on the bridge network
--- 172.17.0.2 ping statistics ---
1 packets transmitted, 0 packets received, 100% packet loss
```

Remember that `alpine4` is connected to both the default `bridge` network and `alpine-net`. It should be able to reach all of the other containers. However, you will need to address alpine3 by its IP address. Attach to it and run the tests.

```bash
docker attach alpine4
```

```bash
##----------- Ping alpine3 by name
/ # ping alpine3
ping: bad address 'alpine3'

##----------- Ping alpine3 by IP address
/ # ping -c 1 172.17.0.2
PING 172.17.0.2 (172.17.0.2): 56 data bytes
64 bytes from 172.17.0.2: seq=0 ttl=64 time=0.382 ms

--- 172.17.0.2 ping statistics ---
1 packets transmitted, 1 packets received, 0% packet loss
round-trip min/avg/max = 0.382/0.382/0.382 ms
/ # 
```

You should also be able to connect to internet from all the containers.

