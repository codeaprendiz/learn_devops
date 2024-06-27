# /etc/resolv.conf

<br>

## /etc/resolv.conf file

Path on mac : /etc/resolv.conf

Each entry can be called as additional search domain.

resolv.conf is the name of a computer file used in various operating systems to configure the system's Domain Name System (DNS) resolver. The file is a plain-text file usually created by the network administrator or by applications that manage the configuration tasks of the system. The resolvconf program is one such program on FreeBSD or other Unix machines which manages the resolv.conf file.

PURPOSE

In most Unix-like operating systems and others that implement the BIND Domain Name System (DNS) resolver library, the resolv.conf configuration file contains information that determines the operational parameters of the DNS resolver. The DNS resolver allows applications running in the operating system to translate human-friendly domain names into the numeric IP addresses that are required for access to resources on the local area network or the Internet. The process of determining IP addresses from domain names is called resolving.

CONTENTS AND LOCATION

The file resolv.conf typically contains directives that specify the default search domains; used for completing a given query name to a fully qualified domain name when no domain suffix is supplied. It also contains a list of IP addresses of nameservers available for resolution. An example file is:

```bash
search example.com local.lan
nameserver 127.0.0.1
nameserver 172.16.1.254
nameserver 172.16.2.254
```

Here `search` says if I try to run the following command

```bash
ping web
```

- Then it would try to looks for `web.example.com` first and then `web.local.lan` and so forth

resolv.conf is usually located in the /etc directory of the file system. The file is either maintained manually, or when DHCP is used, it is usually updated with the utility resolvconf.