## nslookup

### NAME

nslookup - query Internet name servers interactively

### SYNOPSIS

> nslookup [-option] [name | -] [server]

### DESCRIPTION

Nslookup is a program to query Internet domain name servers.  Nslookup has two modes: interactive and non-interactive. Interactive mode allows the user to query name servers for information about various hosts and domains or to print a list of hosts in a domain. Non-interactive mode is used to print just the name and requested information for a host or domain.

### ARGUMENTS

Interactive mode is entered in the following cases:

* when no arguments are given (the default name server will be used)
* when the first argument is a hyphen (-) and the second argument is the host name or Internet address of a name server.

Non-interactive mode is used when the name or Internet address of the host to be looked up is given as the first argument. The optional second argument specifies the host name or address of a name server.

### EXAMPLE1

When nslookup starts, it prints the name and IP address of your local DNS server. Commands

```bash
nslookup
> set type=a
> google.com.
Server: 172.30.93.117
Address: 172.30.93.117#53

Non-authoritative answer:
Name: google.com
Address: 172.217.164.110
> 
```

Note that Non-authoritative answer clause means that you are looking up google.com not the first time, which means that the the name server uses its cache to generate the answer, resulting in the "Non-authoritative" answer.

Using trailing dot at the end of the fully qualified domain name is equivalent to set nosearch (see below.) This is important when debugging DNS servers. The dot is preferred.

```bash
nslookup
> set type=mx
> google.com
Server: 172.30.93.117
Address: 172.30.93.117#53

Non-authoritative answer:
google.com mail exchanger = 20 alt1.aspmx.l.google.com.
google.com mail exchanger = 10 aspmx.l.google.com.
google.com mail exchanger = 50 alt4.aspmx.l.google.com.
google.com mail exchanger = 30 alt2.aspmx.l.google.com.
google.com mail exchanger = 40 alt3.aspmx.l.google.com.

Authoritative answers can be found from:
> 
```

The first four lines show that the domain google.com has four MX records. Mail addressed to that domain is sent to the machine with the lowest preference (cost). If that machine is down or not accepting mail, the message is sent to the machine with the next higher cost, and so on. The last four lines show the IP addresses (A records) for those machines.

Nslookup is a program to query Internet domain name servers.

Domain Name Servers (DNS) are the Internet's equivalent of a phone book. They maintain a directory of domain names and translate them to Internet Protocol (IP) addresses.

```bash
nslookup microsoft.com
Server:     8.8.8.8
Address:    8.8.8.8#53

Non-authoritative answer:
Name:    microsoft.com
Address: 134.170.185.46
Name:    microsoft.com
Address: 134.170.188.221
```

* Here, 8.8.8.8 is the address of our system's Domain Name Server. This is the server our system is configured to use to translate domain names into IP addresses. "#53" indicates that we are communicating with it on port 53, which is the standard port number domain name servers use to accept queries.

* Below this, we have our lookup information for microsoft.com. Our name server returned two entries, 134.170.185.46 and 134.170.188.221. This indicates that microsoft.com uses a round robin setup to distribute server load. When you access micrsoft.com, you may be directed to either of these servers and your packets will be routed to the correct destination.

* You can see that we have received a "Non-authoritative answer" to our query. An answer is "authoritative" only if our DNS has the complete zone (When referring to a computer network, a zone is a location subset of a local-area network (LAN).) file information for the domain in question. More often, our DNS will have a cache of information representing the last authoritative answer it received when it made a similar query; this information is passed on to you, but the server qualifies it as "non-authoritative": the information was recently received from an authoritative source, but the DNS server is not itself that authority.

