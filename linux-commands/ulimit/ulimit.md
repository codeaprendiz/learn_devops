## ulimit


### SYNOPSIS 

> ulimit [-HSTabcdefilmnpqrstuvx [limit]]

### DESCRIPTION 

Provides control over the resources available to the shell and to processes started by it, on systems that allow such control.  

### OPTIONS

*  -a
   * All current limits are reported
*  -b
   * The maximum socket buffer size
*  -c 
   * The maximum size of core files created
*  -d
    * The maximum size of a process's data segment
*  -e
    *The maximum scheduling priority ("nice")
*  -f 
    * The maximum size of files written by the shell and its children
*  -i 
    * The maximum number of pending signals
*  -l 
    * The maximum size that may be locked into memory
*  -m 
    * The maximum resident set size (many systems do not honor this limit) -n     The maximum number of open file descriptors (most systems do not allow this value to be set) -p     The pipe size in 512-byte blocks (this may not be set)
*  -q 
    * The maximum number of bytes in POSIX message queues
*  -r 
    * The maximum real-time scheduling priority
*  -s 
    * The maximum stack size
*  -t 
    * The maximum amount of cpu time in seconds
*  -u 
    * The maximum number of processes available to a single user
*  -v 
    * The maximum amount of virtual memory available to the shell and, on some systems, to its children -x     The maximum number of file locks
*  -T 
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