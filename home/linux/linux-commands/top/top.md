## top

### NAME

top - display and update sorted information about processes

### SYNOPSIS

> top    [-a | -d | -e | -c <mode>]

> top    [-F | -f]

> top   [-h]

> top   [-i <interval>]

> top   [-l <samples>]

> top   [-ncols <columns>]

> top   [-o <key>] [-O <skey>]

> top   [-R | -r]

> top   [-S]

> top   [-s <delay>]

> top   [-n <nprocs>]

> top  [-stats <keys>]

> top   [-pid <processid>]

> top   [-user <username>]

> top   [-U <username>]

> top   [-u]

### DESCRIPTION

The top program periodically displays a sorted list of system processes.  The default sorting key is pid, but other keys can be used instead. Various output options are available.

### OUTPUT INTERPRETATION

```bash
top - 16:35:05 up 962 days, 19:47,  1 user, load average: 0.87, 0.97, 0.93
```

* current time (16:35:05)

* uptime of the machine (up 962  day, 19:47)

* users sessions logged in (1 users)

* average load on the system (load average: 0.87, 0.97, 0.93) the 3 values refer to the last minute, five minutes and 15 minutes.

```bash
Tasks: 372 total,   1 running, 370 sleeping,   0 stopped, 1 zombie
```

* Processes running in totals (372 total)

* Processes running (1 running)

* Processes sleeping (370 sleeping)

* Processes stopped (0 stopped)

* Processes waiting to be stopped from the parent process (1 zombie)

```bash
Cpu(s):  2.8%us, 0.3%sy,  0.0%ni, 96.9%id, 0.0%wa,  0.0%hi, 0.1%si, 0.0%st
```


* Percentage of the CPU for user processes (2.8%us)

* Percentage of the CPU for system processes (0.3%sy)

* Percentage of the CPU processes with priority upgrade nice (0.0%ni)

* Percentage of the CPU not used (96.9%id)

* Percentage of the CPU processes waiting for I/O operations(0.0%wa)

* Percentage of the CPU serving hardware interrupts (0.0% hi — Hardware IRQ

* Percentage of the CPU serving software interrupts (0.1% si — Software Interrupts

* The amount of CPU ‘stolen’ from this virtual machine by the hypervisor for other tasks (such as running another virtual machine) this will be 0 on desktop and server without Virtual machine. (0.0%st — Steal Time)

```bash
Mem:  49474136k total, 45312428k used,  4161708k free, 1024932k buffers
Swap:  4095992k total,   270564k used, 3825428k free, 20027500k cached
```

* The fourth and fifth rows respectively indicate the use of physical memory (RAM) and swap. In this order: Total memory in use, free, buffers cached.

```bash
PID USER      PR NI VIRT RES  SHR S %CPU %MEM TIME+  COMMAND
16909 gie_tx    19 0 1957m 369m 3316 S 11.3  0.8 3:47.36 java
```


* PID – l’ID of the process(16909 )

* USER – The user that is the owner of the process (gie_tx)

* PR – priority of the process (19)

* NI – The “NICE” value of the process (0)

* VIRT – virtual memory used by the process (1957m )

* RES – physical memory used from the process (369m )

* SHR – shared memory of the process (3316 )

* S – indicates the status of the process: S=sleep R=running Z=zombie (S)

* %CPU – This is the percentage of CPU used by this process (11.3)

* %MEM – This is the percentage of RAM used by the process (0.8)

* TIME+ –This is the total time of activity of this process (3:47.36)

* COMMAND – And this is the name of the process (javal)

### OPTIONS

Command line option specifications are processed from left to right.  Options can be specified more than once. If conflicting options are specified, later specifications override  earlier ones. This makes it viable to create a shell alias for top with preferred defaults specified, then override those preferred defaults as desired on the command line.

* -o <key> 
  * Order the process display by sorting on <key> in descending order.  A + or - can be prefixed to the key name to specify ascending or descending order, respectively.  The supported keys are
  * pid    Process ID (default).
  * cpu    CPU usage.
* -p 
  * To get results for a single process
* -M : Detect memory units
  * Show memory units (k/M/G) and display floating point values in the memory summary.
  
### EXAMPLES

```bash
$ top  -o cpu
```

* -p 
  * To get results for a single process
  
```bash
$ top  -p 20171
top - 16:58:27 up 1033 days, 21:07,  2 users, load average: 0.11, 0.07, 0.01
Tasks:   1 total,   0 running,   1 sleeping, 0 stopped,   0 zombie
Cpu(s):  6.6%us, 0.0%sy,  0.0%ni, 93.1%id, 0.0%wa,  0.2%hi, 0.2%si, 0.0%st
Mem:  14105244k total,  9159980k used, 4945264k free,   820460k buffers
Swap:  4095992k total,       96k used, 4095896k free,  2137540k cached

  PID USER      PR NI VIRT RES  SHR S %CPU %MEM TIME+  COMMAND
20171 pie_t    15 0 3078m 1.6g 4540 S  0.0 11.6 996:25.61 java
```

* -M : Detect memory units
  * Show memory units (k/M/G) and display floating point values in the memory summary.
  
```bash
$ top  -M
top - 18:30:13 up 961 days, 21:42,  1 user, load average: 1.26, 0.90, 0.91
Tasks: 376 total,   2 running, 373 sleeping,   0 stopped, 1 zombie
Cpu(s): 26.2%us,  2.6%sy, 0.0%ni, 71.0%id,  0.0%wa, 0.0%hi, 0.2%si, 0.0%st
Mem:    47.182G total,   42.604G used, 4688.285M free,  993.586M buffers
Swap: 3999.992M total,  264.223M used, 3735.770M free,   18.359G cached

  PID USER      PR NI VIRT RES  SHR S %CPU %MEM TIME+  COMMAND
26996 pie_t    21 0 2494m 604m 7364 S 12.9  1.3 1:23.19 java
```