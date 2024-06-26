# ulimit

## SYNOPSIS

> ulimit [-HSTabcdefilmnpqrstuvx [limit]]

## DESCRIPTION

Provides control over the resources available to the shell and to processes started by it, on systems that allow such control.  

## OPTIONS

* -a
  * All current limits are reported
* -b
  * The maximum socket buffer size
* -c
  * The maximum size of core files created
* -d
  * The maximum size of a process's data segment
* -e
    *The maximum scheduling priority ("nice")
* -f
  * The maximum size of files written by the shell and its children
* -i
  * The maximum number of pending signals
* -l
  * The maximum size that may be locked into memory
* -m
  * The maximum resident set size (many systems do not honor this limit) -n     The maximum number of open file descriptors (most systems do not allow this value to be set) -p     The pipe size in 512-byte blocks (this may not be set)
* -q
  * The maximum number of bytes in POSIX message queues
* -r
  * The maximum real-time scheduling priority
* -s
  * The maximum stack size
* -t
  * The maximum amount of cpu time in seconds
* -u
  * The maximum number of processes available to a single user
* -v
  * The maximum amount of virtual memory available to the shell and, on some systems, to its children -x     The maximum number of file locks
* -T
  * The maximum number of threads

```bash
[username@hostname~]$ ulimit -a
core file size          (blocks, -c) unlimited
data seg size           (kbytes, -d) unlimited
scheduling priority             (-e) 0
file size               (blocks, -f) unlimited
pending signals                 (-i) 111795
max locked memory       (kbytes, -l) 64
max memory size         (kbytes, -m) unlimited
open files                      (-n) 65536
pipe size            (512 bytes, -p) 8
POSIX message queues     (bytes, -q) 819200
real-time priority              (-r) 0
stack size              (kbytes, -s) 8192
cpu time               (seconds, -t) unlimited
max user processes              (-u) 16384
virtual memory          (kbytes, -v) unlimited
file locks                      (-x) unlimited
[username@hostname ~]$
```

### /proc/sys/fs/file-max vs ulimit

file-max is the maximum File Descriptors (FD) enforced on a kernel level, which cannot be surpassed by all processes without increasing.

The ulimit is enforced on a process level, which can be less than the file-max. If some user has launched 4 processes and the ulimit configuration for FDs is 1024, each process may open 1024 FDs. The user is not going to be limited to 1024 FDs but the processes which are launched by that user.

```bash
me@superme:~$ ulimit -n 
1024 
me@superme:~$ lsof | grep $USER | wc -l 
8145
```

How do I know if I’m getting close to hitting this limit on my server? Run the command: cat /proc/sys/fs/file-nr. This will return three values, denote the number of allocated file handles, the number of allocated but unused file handles, and the maximum number of file handles. Note that file-nr IS NOT a tunable parameter. It is informational only. On my server, this returns: 3488 0 793759. This means that currently, my server has only allocated 3488 of the 793,759 allocation limit and is in no danger of hitting this limit at this time.
