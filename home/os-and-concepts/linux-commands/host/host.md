## host

### NAME

host - DNS lookup utility

### SYNOPSIS

> host [-aCdlnrsTwv] [-c class] [-N ndots] [-R number] [-t type] [-W wait] [-m flag] [-4] [-6] [-v] [-V] {name} [server]

### DESCRIPTION

host is a simple utility for performing DNS lookups. It is normally used to convert names to IP addresses and vice versa. When no arguments or options are given, host prints a short summary of its command line arguments and options.

**name** 

is the domain name that is to be looked up. It can also be a dotted-decimal IPv4 address or a colon-delimited IPv6 address, in which case host will by default perform a reverse lookup for that address.  server is an optional argument which is either the name or IP address of the name server that host should query instead of the server or servers listed in /etc/resolv.conf.

### OPTIONS

* -4
  * Use IPv4 only for query transport. See also the -6 option.
* -6
  * Use IPv6 only for query transport. See also the -4 option.
* -a
  * "All". The -a option is normally equivalent to -v -t ANY. It also affects the behaviour of the -l list zone option.
* -c class
  * Query class: This can be used to lookup HS (Hesiod) or CH (Chaosnet) class resource records. The default class is IN (Internet).
* -C
  * Check consistency: host will query the SOA records for zone name from all the listed authoritative name servers for that zone. The list of name servers is defined by the NS records that are found for the zone.
* -d
  * Print debugging traces. Equivalent to the -v verbose option.
* -l
  * List zone: The host command performs a zone transfer of zone name and prints out the NS, PTR and address records (A/AAAA). Together, the -l -a options print all records in the zone.
  
  
```bash
$ host google.com
google.com has address 172.217.9.174
google.com has IPv6 address 2607:f8b0:4000:814::200e
google.com mail is handled by 10 aspmx.l.google.com.
google.com mail is handled by 30 alt2.aspmx.l.google.com.
google.com mail is handled by 20 alt1.aspmx.l.google.com.
google.com mail is handled by 40 alt3.aspmx.l.google.com.
google.com mail is handled by 50 alt4.aspmx.l.google.com.
```