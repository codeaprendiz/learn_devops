## telnet

### NAME

telnet -- user interface to the TELNET protocol

### SYNOPSIS

> telnet [-468EFKLNacdfruxy] [-S tos] [-X authtype] [-e escapechar] [-k realm] [-l user] [-n tracefile] [-s src_addr] [host [port]]

### DESCRIPTION

The telnet command is used to communicate with another host using the TELNET protocol.  If telnet is invoked without the host argument, it enters command mode, indicated by its prompt (``telnet>'').  In this mode, it accepts and executes the commands listed below. If it is invoked with arguments, it performs an open command with those arguments.

### OPTIONS

### EXAMPLES

The telnet commands allow you to communicate with a remote computer that is using the Telnet protocol. You can run telnet without parameters in order to enter the telnet context, indicated by the Telnet prompt (telnet>). 


```bash
$ nslookup google.com
Server: 192.168.1.1
Address: 192.168.1.1#53

Non-authoritative answer:
Name: google.com
Address: 216.58.196.174
```

Now get the Non Authoritative Answer IP address.

```bash
telnet 216.58.196.174 80
Trying 216.58.196.174...
Connected to maa03s31-in-f14.1e100.net.
Escape character is '^]'.
```

Here 80 is the port number.
