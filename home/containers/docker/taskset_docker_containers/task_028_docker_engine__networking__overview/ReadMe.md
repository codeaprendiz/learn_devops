# [Networking overview](https://docs.docker.com/engine/network/)

Here's the information in a tabular format suitable for a README file:

| **Driver** | **Description**                                                                                  |
|------------|--------------------------------------------------------------------------------------------------|
| bridge     | The default network driver.                                                                      |
| host       | Removes network isolation between the container and the Docker host.                             |
| none       | Completely isolates a container from the host and other containers.                              |
| overlay    | Connects multiple Docker daemons together.                                                       |
| ipvlan     | Provides full control over both IPv4 and IPv6 addressing.                                        |
| macvlan    | Assigns a MAC address to a container, allowing it to appear as a physical device on the network. |

The following example creates a network using the bridge network driver and running a container in the created network:

```bash
docker network create -d bridge my-net
docker run --network=my-net -itd --name=container3 busybox
```

Validation

```bash
docker network ls | egrep "my-net|NETWORK"
```

Output

```bash
NETWORK ID     NAME                        DRIVER    SCOPE
3b034b1f4229   my-net                      bridge    local
```

```bash
docker network inspect my-net --format='{{json .IPAM.Config}}' | jq .
```

Output

```json
[
  {
    "Subnet": "172.20.0.0/16",
    "Gateway": "172.20.0.1"
  }
]
```

Retrieve container details

```bash
docker network inspect my-net --format='{{json .Containers}}' | jq .
```

Output

```json
{
  "xxxxxxxxxxxxxxxxxxxx": {
    "Name": "container3",
    "EndpointID": "xxxxxxxxxxxxxxx",
    "MacAddress": "x.x.x.x.x.",
    "IPv4Address": "172.20.0.2/16",
    "IPv6Address": ""
  }
}
```

**Subnet Mask Explanation**: `/16` means that the first 16 bits of the IP address are used for the network part, and the remaining bits are used for the host part. This subnet mask corresponds to `255.255.0.0`, which means the network is `172.20.0.0` and the IP address `172.20.0.2` is part of that network.

---

The following example runs a Redis container, with Redis binding to localhost, then running the redis-cli command and connecting to the Redis server over the `container's localhost interface`.

```bash
docker run -d --name redis redis --bind 127.0.0.1
docker run --rm -it --network container:redis redis redis-cli -h 127.0.0.1
```

Output

```bash
127.0.0.1:6379> 
```

---

If you include the localhost IP address (127.0.0.1, or ::1) with the publish flag, only the Docker host and its containers can access the published container port.

```bash
docker run -p 127.0.0.1:8080:80 -p '[::1]:8080:80' nginx
```
