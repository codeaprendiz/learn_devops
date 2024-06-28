# lsof

## NAME

lsof - list open files
  
## EXAMPLES on macOS

To check which process is using port 8080 use the following command

[stackoverflow.com » Who is listening on a given TCP port on Mac OS X?](https://stackoverflow.com/questions/4421633/who-is-listening-on-a-given-tcp-port-on-mac-os-x)

```bash
# -i : selects the listing of files any of whose Internet address matches the address specified in i.  If no address is specified, this option selects the listing of all Internet and x.25 (HP-UX) network files.
# -P : inhibits the conversion of port numbers to port names for network files.
# -n : inhibits the conversion of network numbers to host names for network files.
lsof -i -P -n | grep LISTEN | egrep :8080
```

Output

```bash
$ lsof -i -P -n | grep LISTEN | egrep :8080
main      12615 <username>    8u  IPv6 0xxxxxxxxxxxxxx     0t0  TCP *:8080 (LISTEN)
```
