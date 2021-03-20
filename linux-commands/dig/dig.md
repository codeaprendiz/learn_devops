## dig

[dig](https://linux.die.net/man/1/dig)

### NAME

dig - DNS lookup utility

### SYNOPSIS

> dig [@server] [-b address] [-c class] [-f filename] [-k filename] [-m] [-p port#] [-q name] [-t type] [-x addr] [-y [hmac:]name:key] [-4] [-6] [name] [type] [class][queryopt...]

>dig [-h]

>dig [global-queryopt...] [query...]

### DESCRIPTION

dig (domain information groper) is a flexible tool for interrogating DNS name servers. 
It performs DNS lookups and displays the answers that are returned from the name server(s) that were queried. 
Unless it is told to query a specific name server, dig will try each of the servers listed in /etc/resolv.conf.
When no command line arguments or options are given, dig will perform an NS query for "." (the root).
As mentioned in synopsis
server 
Is the name or IP address of the name server to query. 
This can be an IPv4 address in dotted-decimal notation or an IPv6 address in colon-delimited notation. 
When the supplied server argument is a hostname, dig resolves that name before querying that name server. 
If no server argument is provided, dig consults /etc/resolv.conf and queries the name servers listed there.
The reply from the name server that responds is displayed.
name
Is the name of the resource record that is to be looked up.
type
Indicates what type of query is required -- ANY, A, MX, SIG, etc.  
Type can be any valid query type. 
If no type argument is supplied, dig will perform a lookup for an A record.

### OPTIONS

- +[no]trace

    - Toggle tracing of the delegation path from the root name servers for the name being looked up.
      Tracing is disabled by default. 
      When tracing is enabled, dig makes iterative queries to resolve the name being looked up. 
      It will follow referrals from the root servers, showing the answer from each server that was used to resolve the lookup.
      
- -t

  - The -t option sets the query type to type      

**OUTPUT EXPLANATION**

```bash
$ dig example.com

; <<>> DiG 9.8.3-P1 <<>> example.com
;; global options: +cmd
;; Got answer:
;; ->>HEADER<<- opcode: QUERY, status: NOERROR, id: 6033
;; flags: qr rd ra; QUERY: 1, ANSWER: 1, AUTHORITY: 0, ADDITIONAL: 0

;; QUESTION SECTION:
;example.com. IN A

;; ANSWER SECTION:
example.com. 19727 IN A 93.184.216.34

;; Query time: 8 msec
;; SERVER: 172.30.93.117#53(172.30.93.117)
;; WHEN: Sat Jun  9 15:59:50 2018
;; MSG SIZE  rcvd: 45
```


```bash
; <<>> DiG 9.8.3-P1 <<>> example.com
```

The first line of the DIG indicates what version of the utility is currently installed, and the query that was invoked.

```bash
;; global options: +cmd
```

Default instance of DIG was set up to display the first line of the response.

```bash
;; Got answer:
;; ->>HEADER<<- opcode: QUERY, status: NOERROR, id: 6033
;; flags: qr rd ra; QUERY: 1, ANSWER: 1, AUTHORITY: 0, ADDITIONAL: 0
```

Got an answer, hooray! The first part of the answer is the header, which has been clearly marked up with all manner of operators. 

The opcode is the action that DIG took, in this case a query. 

Status is an important one to note; in this case, there was no error reported. 

This field may show one of the following statuses when a query is invoked:

- NOERROR - Everything's cool. The zone is being served from the requested authority without issues.
- SERVFAIL - The name that was queried exists, but there's no data or invalid data for that name at the requested authority. 
- NXDOMAIN - The name in question does not exist, and therefore there is no authoritative DNS data to be served.
- REFUSED - Not only does the zone not exist at the requested authority, but their infrastructure is not in the business of serving things that don't exist at all.

Next line starts out with flags - these are options that can be set to determine which sections of the answer get printed, or determine the timeout and retry strategies. 

The subsequent fields, Query, Answer, Authority and Additional provide the count of results for the DIG that was performed.

Here note that AUTHORITY=0 as this is not an authoritative an

```bash
;; QUESTION SECTION:
;example.com. IN A
```

The question section reaffirms what you went looking for - in this case, DIG went looking for an IPv4 address (A Record) at example.com.

```bash
;; ANSWER SECTION:
example.com. 19727 IN A 93.184.216.34

;; Query time: 8 msec
;; SERVER: 172.30.93.117#53(172.30.93.117)
;; WHEN: Sat Jun  9 15:59:50 2018
;; MSG SIZE  rcvd: 45
```

We see that example.com, with a TTL of 19727 seconds has an A record - 93.184.216.34.

Query time shows how long it took to get the DNS response back from the server, which is listed on the next line. 

You can also see the exact moment in time that I requested this information, and how many bytes the response contained.


### EXAMPLE

- dig +trace 

```bash
$ dig +trace www.example.com

; <<>> DiG 9.8.3-P1 <<>> +trace www.example.com
;; global options: +cmd
. 85622 IN NS i.root-servers.net.
. 85622 IN NS h.root-servers.net.
. 85622 IN NS j.root-servers.net.
. 85622 IN NS f.root-servers.net.
. 85622 IN NS b.root-servers.net.
. 85622 IN NS k.root-servers.net.
. 85622 IN NS e.root-servers.net.
. 85622 IN NS a.root-servers.net.
. 85622 IN NS d.root-servers.net.
. 85622 IN NS l.root-servers.net.
. 85622 IN NS c.root-servers.net.
. 85622 IN NS g.root-servers.net.
. 85622 IN NS m.root-servers.net.
;; Received 228 bytes from 172.30.93.117#53(172.30.93.117) in 2748 ms

com. 172800 IN NS l.gtld-servers.net.
com. 172800 IN NS k.gtld-servers.net.
com. 172800 IN NS e.gtld-servers.net.
com. 172800 IN NS a.gtld-servers.net.
com. 172800 IN NS h.gtld-servers.net.
com. 172800 IN NS c.gtld-servers.net.
com. 172800 IN NS f.gtld-servers.net.
com. 172800 IN NS b.gtld-servers.net.
com. 172800 IN NS m.gtld-servers.net.
com. 172800 IN NS i.gtld-servers.net.
com. 172800 IN NS d.gtld-servers.net.
com. 172800 IN NS j.gtld-servers.net.
com. 172800 IN NS g.gtld-servers.net.
;; Received 493 bytes from 192.5.5.241#53(192.5.5.241) in 2976 ms

example.com. 172800 IN NS a.iana-servers.net.
example.com. 172800 IN NS b.iana-servers.net.
;; Received 169 bytes from 192.42.93.30#53(192.42.93.30) in 871 ms

www.example.com. 86400 IN A 93.184.216.34
example.com. 86400 IN NS a.iana-servers.net.
example.com. 86400 IN NS b.iana-servers.net.
;; Received 97 bytes from 199.43.135.53#53(199.43.135.53) in 221 ms
```

- Similar to above example we can get an authoritative answer if we pass the dns server also
   Here in response note that the AUTHORITY=1 and we specifically have an AUTHORITY section.
   
```bash
dig example.com @dns1.p01.nsone.net                                                  


; <<>> DiG 9.8.3-P1 <<>> example.com @dns1.p01.nsone.net
;; global options: +cmd
;; Got answer:
;; ->>HEADER<<- opcode: QUERY, status: NOERROR, id: 39561
;; flags: qr aa rd; QUERY: 1, ANSWER: 0, AUTHORITY: 1, ADDITIONAL: 0
;; WARNING: recursion requested but not available

;; QUESTION SECTION:
;example.com. IN A

;; AUTHORITY SECTION:
example.com. 3600 IN SOA dns1.p08.nsone.net. hostmaster.nsone.net. 1528386225 43200 7200 1209600 3600

;; Query time: 228 msec
;; SERVER: 198.51.44.1#53(198.51.44.1)
;; WHEN: Sat Jun  9 16:42:19 2018
;; MSG SIZE  rcvd: 94
```

- To validate TXT DNS record type

```bash
$ dig -t txt company.com
; <<>> DiG 9.10.6 <<>> -t txt company.com
;; global options: +cmd
;; Got answer:
;; ->>HEADER<<- opcode: QUERY, status: NOERROR, id: 35904
;; flags: qr rd ra; QUERY: 1, ANSWER: 3, AUTHORITY: 0, ADDITIONAL: 1
;; OPT PSEUDOSECTION:
; EDNS: version: 0, flags:; udp: 4000
;; QUESTION SECTION:
;company.com.                 IN      TXT
;; ANSWER SECTION:
company.com.          99      IN      TXT     "sitebook-domain-verification=5tasdfawer23lksdfjasof2349238qs177h9h"
company.com.          99      IN      TXT     "lopgle-site-verification=22nceW2432fdsf41GDnKzLhZasdf3410N1gGv9DC__VPaMocsdfdsf342344MuphZsrU"
;; Query time: 134 msec
;; SERVER: 192.168.0.100#53(192.168.0.100)
;; WHEN: Tue Feb 02 16:53:43 +04 2021
;; MSG SIZE  rcvd: 268
```


- Dig the ns records for a given domain

```bash
$ dig ns devopsk8.com            

; <<>> DiG 9.10.6 <<>> ns devopsk8.com
;; global options: +cmd
;; Got answer:
;; ->>HEADER<<- opcode: QUERY, status: NOERROR, id: 55429
;; flags: qr rd ra; QUERY: 1, ANSWER: 4, AUTHORITY: 0, ADDITIONAL: 1

;; OPT PSEUDOSECTION:
; EDNS: version: 0, flags:; udp: 4096
;; QUESTION SECTION:
;devopsk8.com.                  IN      NS

;; ANSWER SECTION:
devopsk8.com.           172800  IN      NS      ns-1991.awsdns-56.co.uk.
devopsk8.com.           172800  IN      NS      ns-1442.awsdns-52.org.
devopsk8.com.           172800  IN      NS      ns-157.awsdns-19.com.
devopsk8.com.           172800  IN      NS      ns-945.awsdns-54.net.

;; Query time: 222 msec
;; SERVER: 195.229.241.222#53(195.229.241.222)
;; WHEN: Sat Mar 20 13:57:38 +04 2021
;; MSG SIZE  rcvd: 178
```

- Dig soa record type for given domain

```bash
$ dig soa devopsk8.com                              

; <<>> DiG 9.10.6 <<>> soa devopsk8.com
;; global options: +cmd
;; Got answer:
;; ->>HEADER<<- opcode: QUERY, status: NOERROR, id: 25736
;; flags: qr rd ra; QUERY: 1, ANSWER: 1, AUTHORITY: 0, ADDITIONAL: 1

;; OPT PSEUDOSECTION:
; EDNS: version: 0, flags:; udp: 4096
;; QUESTION SECTION:
;devopsk8.com.                  IN      SOA

;; ANSWER SECTION:
devopsk8.com.           857     IN      SOA     ns-157.awsdns-19.com. awsdns-hostmaster.amazon.com. 1 7200 900 1209600 86400

;; Query time: 4 msec
;; SERVER: 213.42.20.20#53(213.42.20.20)
;; WHEN: Sat Mar 20 14:03:31 +04 2021
;; MSG SIZE  rcvd: 119
```