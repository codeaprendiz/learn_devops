To check if the IP address belongs to given CIDR range

[Link](https://tehnoblog.org/ip-tools/ip-address-in-cidr-range/)

![](../../images/tools/task-003-if-IP-belongs-to-CIDR/if_ip_in_CIDR.png)



You can check in [Python](https://stackoverflow.com/questions/39358869/check-if-an-ip-is-within-a-range-of-cidr-in-python) as well

```bash
>>> from ipaddress import ip_network, ip_address
>>> net = ip_network("1.1.0.0/16")
>>> print(ip_address("1.1.2.2") in net) 
True
```