# nc

<br>

## NAME

nc -- arbitrary TCP and UDP connections and listens

<br>

## SYNOPSIS

> nc [-46AcDCdhklnrtUuvz] [-b boundif] [-i interval] [-p source_port] [-s source_ip_address] [-w timeout] [-X proxy_protocol] [-x proxy_address[:port]][--apple-delegate-pid pid] [--apple-delegate-uuid uuid] [--apple-ext-bk-idle] [--apple-nowakefromsleep] [--apple-ecn mode] [hostname] [port[s]]

<br>

## DESCRIPTION

The nc (or netcat) utility is used for just about anything under the sun involving TCP or UDP.  It can open TCP connections, send UDP packets, listen on arbitrary TCP and UDP ports, do port scanning, and deal with both IPv4 and IPv6.  Unlike telnet(1), nc scripts nicely, and separates error messages onto standard error instead of sending them to standard output, as telnet(1) does with some.

Common uses include:

* simple TCP proxies
* shell-script based HTTP clients and servers
* network daemon testing
* a SOCKS or HTTP ProxyCommand for ssh(1)

<br>

## OPTIONS

* -v
  * Have nc give more verbose output.

* -u
  * Use UDP instead of the default option of TCP

* -s
  * source_ip_address
  * Specifies the IP of the interface which is used to send the packets.  It is an error to use this option in conjunction with the -l option.

* -w timeout
  * If a connection and stdin are idle for more than timeout seconds, then the connection is silently closed.  The -w flag has no effect on the -l option, i.e. nc will listen forever for a connection, with or without the -w flag.  The default is no timeout.

<br>

## EXAMPLE

* Open a TCP connection to port 42 of host.example.com, using port 31337 as the source port, with a
timeout of 5 seconds:

```bash
$ nc -p 31337 -w 5 host.example.com 42 -v
.
```

* To validate whether a particual UDP port on a host is open or not [serverfault.com](https://serverfault.com/questions/416205/testing-udp-port-connectivity)

```bash
<br>

########### Tested on ORACLE LINUX SERVER 8.7 ###################
# Server Machine, this is were we need to test whether a particual port is open or not, let's say 6111
user@server $  nc -ul 6111 -v
Ncat: Version 7.70 ( https://nmap.org/ncat )
Ncat: Listening on :::6111
Ncat: Listening on 0.0.0.0:6111

# Client Machine, from where we want to test the connectivity to server machine via UDP protocol
user@client $ nc -u <server_ip_here> 6111 -v
Ncat: Version 7.70 ( https://nmap.org/ncat )
Ncat: Connected to <server_ip_here>:6111.

# You type a message on the client machine and press enter, you should see the message on the server side
# You might want to disable the OS firewall, see systemctl status firewalld, also you might want to ensure the the UDP protocol is allowed by any security groups or network security groups coming in between
# Client Machine, from where we want to test the connectivity to server machine via UDP protocol
user@client $ nc -u <server_ip_here> 6111 -v
Ncat: Version 7.70 ( https://nmap.org/ncat )
Ncat: Connected to <server_ip_here>:6111.
hi, from the client

<br>

################################ When you don't see the message on the server side ######################################################
# Server machine, in case you don't see the message then the port may or maynot be open, we cannot be sure until we rule out security groups / network security groups are checked
# So the following scenario
user@server $  nc -ul 6111 -v
Ncat: Version 7.70 ( https://nmap.org/ncat )
Ncat: Listening on :::6111
Ncat: Listening on 0.0.0.0:6111


<br>

################################ When you see the message on the server side ######################################################
# Incase the port is open, you should see the same message on the server side, also a msg saying that there was a connection from <client_ip>
user@server $ nc -ul 6111 -v
Ncat: Version 7.70 ( https://nmap.org/ncat )
Ncat: Listening on :::6111
Ncat: Listening on 0.0.0.0:6111
Ncat: Connection from <client_ip_here>.
hi, from the client


<br>

#####################################  nc -uz <server_ip> <port> seems to give a FASLE positive, i.e. true even when the port is not open ######
# The following is example of FALSE POSITIVE, i.e. when the PORT CONNECTIVITY ISN"T ACTUALLY ALLOWED
$ user@client $ nc -uz <server_ip_here> 6111 -v
Ncat: Version 7.70 ( https://nmap.org/ncat )
Ncat: Connected to <server_ip_here>:6111.
Ncat: UDP packet sent successfully
Ncat: 1 bytes sent, 0 bytes received in 2.01 seconds.
```

* Open a TCP connection to port 42 of host.example.com using 10.1.2.3 as the IP for the local end of the connection:

```bash
$ nc -s 10.1.2.3 host.example.com 42 
.
```

* Open a TCP connection to port 1521 of 127.0.0.1 :

```bash
$ nc -w 3 127.0.0.1 1521 -v
.
```
