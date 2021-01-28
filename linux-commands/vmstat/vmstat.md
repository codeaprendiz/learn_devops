## vmstat

### NAME

vmstat - Report virtual memory statistics

### SYNOPSIS

> vmstat [-a] [-n] [-S unit] [delay [ count]]

> vmstat [-s] [-n] [-S unit]

> vmstat [-m] [-n] [delay [ count]]

> vmstat [-d] [-n] [delay [ count]]

> vmstat [-p disk partition] [-n] [delay [ count]]

> vmstat [-f]

> vmstat [-V]

### DESCRIPTION

vmstat reports information about processes, memory, paging, block IO, traps, and cpu activity. The  first report produced gives averages since the last reboot. Additional reports give information on a sampling period of length delay.  The process and memory reports are instantaneous in either case.


```bash
[ngcs_tg@dolnxprdxnvm33 ~]$ vmstat
procs -----------memory---------- ---swap-- -----io---- --system-- -----cpu------
 r  b swpd   free buff  cache si so    bi bo in cs us sy id wa st
 0  0 270564 4729352 1017836 19267912    0 0 4 45 0 0 6 1 93  0 0
```