## free


### NAME

free - Display amount of free and used memory in the system

### SYNOPSIS

> free [-b | -k | -m] [-o] [-s delay ] [-t] [-V]

### DESCRIPTION

free displays the total amount of free and used physical and swap memory in the system, as well as the buffers used by the  kernel. 

The shared memory column should be ignored; it is obsolete.

### OPTIONS

* -b 
  * switch  displays the  amount of memory in bytes; the -k switch (set by default) displays it in kilobytes; the  -m switch displays it in megabytes.
* -t 
  * switch displays a line containing the totals.
* -o 
  * switch disables the display of a "buffer adjusted" line
* -s 
  * switch activates continuous polling delay seconds apart. 
  * You may actually specify any floating  point number for delay, usleep(3) is used for microsecond resolution delay times.
  
```bash
[username@hostname~]$ free -m
             total       used free     shared buffers   cached
Mem:         48314 45509       2805 0 992      20808
-/+ buffers/cache:      23708 24606
Swap:         3999 264       3735
```