## nc

### NAME

nc -- arbitrary TCP and UDP connections and listens

### SYNOPSIS

> nc [-46AcDCdhklnrtUuvz] [-b boundif] [-i interval] [-p source_port] [-s source_ip_address] [-w timeout] [-X proxy_protocol] [-x proxy_address[:port]][--apple-delegate-pid pid] [--apple-delegate-uuid uuid] [--apple-ext-bk-idle] [--apple-nowakefromsleep] [--apple-ecn mode] [hostname] [port[s]]

### DESCRIPTION

The nc (or netcat) utility is used for just about anything under the sun involving TCP or UDP.  It can open TCP connections, send UDP packets, listen on arbitrary TCP and UDP ports, do port scanning, and deal with both IPv4 and IPv6.  Unlike telnet(1), nc scripts nicely, and separates error messages onto standard error instead of sending them to standard output, as telnet(1) does with some.

Common uses include:

* simple TCP proxies
* shell-script based HTTP clients and servers
* network daemon testing
* a SOCKS or HTTP ProxyCommand for ssh(1)

### OPTIONS

* -v      
  * Have nc give more verbose output.

* -u      
  * Use UDP instead of the default option of TCP

* -s 
  * source_ip_address
  * Specifies the IP of the interface which is used to send the packets.  It is an error to use this option in conjunction with the -l option.

* -w timeout
  * If a connection and stdin are idle for more than timeout seconds, then the connection is silently closed.  The -w flag has no effect on the -l option, i.e. nc will listen forever for a connection, with or without the -w flag.  The default is no timeout.

### EXAMPLE

Open a TCP connection to port 42 of host.example.com, using port 31337 as the source port, with a 
timeout of 5 seconds:

```bash
$ nc -p 31337 -w 5 host.example.com 42
```

Open a UDP connection to port 53 of host.example.com:

```bash
$ nc -u host.example.com 53
```

Open a TCP connection to port 42 of host.example.com using 10.1.2.3 as the IP for the local end of the connection:

```bash
$ nc -s 10.1.2.3 host.example.com 42
```

Open a TCP connection to port 1521 of 127.0.0.1 :

```bash
$ nc -w 3 -v 127.0.0.1 1521
```