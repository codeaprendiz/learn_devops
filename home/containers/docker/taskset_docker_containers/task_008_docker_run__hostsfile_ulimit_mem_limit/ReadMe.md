# Hosts file, ulimit, memory limit

<br>

## Hosts file

[add-entries-to-container-hosts-file---add-host](https://docs.docker.com/engine/reference/commandline/run/#add-entries-to-container-hosts-file---add-host)

```bash
<br>

## get IP from ping google.com 
❯ docker run --add-host=myhost:142.250.181.78 --rm -it alpine
/ # ping myhost
PING myhost (142.250.181.78): 56 data bytes
64 bytes from 142.250.181.78: seq=0 ttl=37 time=19.929 ms
```

<br>

## ulimit

[set-ulimits-in-container---ulimit](https://docs.docker.com/engine/reference/commandline/run/#set-ulimits-in-container---ulimit)

```bash
❯ docker run --rm debian sh -c "ulimit -n" 
1048576

❯ docker run --ulimit nofile=1024:1024 --rm debian sh -c "ulimit -n"
1024
```

<br>

## Memory limit

[specify-hard-limits-on-memory-available-to-containers--m---memory](https://docs.docker.com/engine/reference/commandline/run/#specify-hard-limits-on-memory-available-to-containers--m---memory)

```bash
<br>

## Terminal session 1
❯ docker run --rm -it  ubuntu             

<br>

## Terminal session 2
❯ docker stats

<br>

## Terminal session 1
❯ docker run --rm -it --memory="2g" ubuntu

<br>

## Terminal session 2
❯ docker stats
```