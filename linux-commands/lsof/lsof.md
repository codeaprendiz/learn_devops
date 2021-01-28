## lsof

### NAME

lsof - list open files

### SYNOPSIS

> lsof  [ -?abChKlnNOPRtUvVX ] [ -A A ] [ -c c ] [ +c c ] [ +|-d d ] [ +|-D D ] [ +|-e s ] [ +|-E ] [ +|-f [cfgGn] ] [ -F [f] ] [ -g [s] ] [ -i [i] ] [ -k k ] [ +|-L [l] ] [ +|-m m ] [ +|-M ] [ -o [o] ] [ -p s ] [ +|-r [t[m<fmt>]] ] [ -s [p:s] ] [ -S [t] ] [ -T [t] ] [ -u s ] [ +|-w ] [ -x [fl] ] [ -z [z] ] [ -Z [Z] ] [ -- ] [names]

DESCRIPTION

Lsof revision 4.89 lists on its standard output file information about files opened by processes for the following UNIX dialects:
- Apple Darwin 9 and Mac OS X 10.[567]
- FreeBSD 8.[234], 9.0, 10.0 and 11.0 for AMD64-based systems
- Linux 2.1.72 and above for x86-based systems
- Solaris 9, 10 and 11

An open file may be a regular file, a directory, a block special file, a character special file, an executing text reference, a library, a stream or a  network file (Internet socket, NFS file or UNIX domain socket.) A specific file or all the files in a file system may be selected by path.

Instead  of a formatted display, lsof will produce output that can be parsed by other programs.  See the -F, option description, and the OUTPUT FOR OTHER PROGRAMS section for more information.

In addition to producing a single output list, lsof will run in repeat mode.  In repeat mode it will produce output, delay, then repeat the output operation until stopped  with an interrupt or quit signal. See the +|-r [t[m<fmt>]] option description for more information.

### OPTIONS

* -i [i]   

  * selects the listing of files any of whose Internet address matches the address specified in i.  If no address is specified, this option selects the listing of all Internet and x.25 (HP-UX) network files.
  * If  -i4 or -i6 is specified with no following address, only files of the indicated IP version, IPv4 or IPv6, are displayed.
  * Multiple addresses (up to a limit of 100) may be specified with multiple -i options.  (A port number or service name range is counted as one address.) They are joined in a single ORed set before participating in AND option selection.

  * An Internet address is specified in the form (Items in square brackets are optional.):

    * [46][protocol][@hostname|hostaddr][:service|port]
    * Where:
      * 46 specifies the IP version, IPv4 or IPv6 that applies to the following address. '6' may be be specified only if the UNIX dialect supports IPv6.  If neither '4' nor '6' is specified, the following address applies to all IP versions. 
      * protocol is a protocol name - TCP, UDP
      * hostname is an Internet host name.  Unless a specific IP version is specified, open network files associated with host names of all versions will be selected. 
      * hostaddr is a numeric Internet IPv4 address in dot form; or an IPv6 numeric address in colon form, enclosed in brackets, if the UNIX dialect supports IPv6.  When an IP version is selected, only its numeric addresses may be specified. 
      * service is an /etc/services name - e.g., smtp - or a list of them.
      * port is a port number, or a list of them.

  * At  least  one address  component - 4, 6, protocol, hostname, hostaddr, or service - must be supplied.  The `@' character, leading the host specification, is always required; as is the `:', leading the port specification.  Specify either hostname or hostaddr. Specify either service name list or port number list. If a service name list  is specified, the protocol may also need to be specified if the TCP, UDP and UDPLITE port numbers for the service name are different.  Use any case - lower or upper - for protocol.
  * Service names and port numbers may be combined in a list whose entries are separated by commas and whose numeric range entries are separated by minus signs.  There may be no embedded spaces, and all service names must belong to the specified protocol. Since service names may contain embedded minus signs, the starting entry of a range can't be a service name; it can be a port number, however.

  * Examples
    * -i6 - IPv6 only
    * TCP:25 - TCP and port 25
    * @1.2.3.4 - Internet IPv4 host address 1.2.3.4
    * @[3ffe:1ebc::1]:1234 - Internet IPv6 host address 3ffe:1ebc::1, port 1234
    * UDP:who - UDP who service port
    * TCP@lsof.itap:513 - TCP, port 513 and host name lsof.itap
    * tcp@foo:1-10,smtp,99 - TCP, ports 1 through 10, service name smtp, port 99, host name foo
    * tcp@bar:1-smtp - TCP, ports 1 through smtp, host bar
    * :time - either TCP, UDP or UDPLITE time service port

* -P      
  * inhibits  the conversion  of port numbers to port names for network files.  Inhibiting the conversion may make lsof run a little faster.  It is also useful when port name lookup is not working properly.

* -n       
  * inhibits the conversion of network numbers to host names for network files.  Inhibiting conversion may make lsof run faster. It is also useful when host name  lookup is not working properly.
  

### EXAMPLES

- -i

```bash
$ lsof -i :8000
COMMAND   PID USER   FD TYPE         DEVICE SIZE/OFF NODE NAME
Python  67100 asr000p    7u IPv4 0x2daeb57757439a85      0t0 TCP localhost:irdmi (LISTEN)
```

- To check the port numbers type the following command

```bash
sudo lsof -i -P -n | grep LISTEN
sshd    85379   root 3u  IPv4 0xffff80000039e000      0t0 TCP 10.86.128.138:22 (LISTEN)
```

- Here
  - sshd is the name of the application.
  - 10.86.128.138 is the IP address to which sshd application bind to (LISTEN)
  - 22 is the TCP port that is being used (LISTEN)
  - 85379 is the process ID of the sshd process