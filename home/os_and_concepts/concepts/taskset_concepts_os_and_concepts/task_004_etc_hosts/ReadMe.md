# /etc/hosts

## /etc/hosts file

The computer file hosts is an operating system file that maps hostnames to IP addresses. It is a plain text file. Originally a file named HOSTS.TXT was manually maintained and made available via file sharing by Stanford Research Institute for the ARPANET membership, containing the hostnames and address of hosts as contributed for inclusion by member organizations. The Domain Name System, first described in 1983 and implemented in 1984, automated the publication process and provided instantaneous and dynamic hostname resolution in the rapidly growing network. In modern operating systems, the hosts file remains an alternative name resolution mechanism, configurable often as part of facilities such as the Name Service Switch as either the primary method or as a fallback method.

PURPOSE

The hosts file is one of several system facilities that assists in addressing network nodes in a computer network. It is a common part of an operating system's Internet Protocol (IP) implementation, and serves the function of translating human-friendly hostnames into numeric protocol addresses, called IP addresses, that identify and locate a host in an IP network.

In some operating systems, the contents of the hosts file is used preferentially to other name resolution methods, such as the Domain Name System (DNS), but many systems implement name service switches, e.g., nsswitch.conf for Linux and Unix, to provide customization. Unlike remote DNS resolvers, the hosts file is under the direct control of the local computer's administrator.

FILE CONTENT

The hosts file contains lines of text consisting of an IP address in the first text field followed by one or more host names. Each field is separated by white space – tabs are often preferred for historical reasons, but spaces are also used. Comment lines may be included; they are indicated by an octothorpe (#) in the first position of such lines. Entirely blank lines in the file are ignored. For example, a typical hosts file may contain the following:

```bash
127.0.0.1  localhost loopback
::1        localhost
```

This example only contains entries for the loopback addresses of the system and their host names, a typical default content of the hosts file. The example illustrates that an IP address may have multiple host names (localhost and loopback), and that a host name may be mapped to both IPv4 and IPv6 IP addresses, as shown on the first and second lines respectively.
Your browser you go to this 172.16.104.21  IP address first to get the response.

```bash
##
# Host Database
#
# localhost is used to configure the loopback interface
# when the system is booting.  Do not change this entry.
##
127.0.0.1 localhost
255.255.255.255 broadcasthost
::1             localhost
172.16.104.21   test.oms.qa.domain.com
```
