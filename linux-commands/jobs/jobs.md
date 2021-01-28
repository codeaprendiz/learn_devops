## jobs

JOB CONTROL

Job control is nothing but the ability to stop/suspend the execution of processes (command) and continue/resume their execution as per your requirements. 
This is done using your operating system and shell such as bash/ksh or POSIX shell.
Your shell keeps a table of currently executing jobs and can be displayed with jobs command.

### DESCRIPTION

It's a shell builtin
Shell builtin commands are commands that can be executed within the running shell's process.

### PURPOSE

Displays status of jobs in the current shell session.

### SYNTAX

> jobs [-lnprs] [ jobspec ... ]

> jobs -x command [ args ... 

The basic syntax is as follows:
- jobs
- jobs jobID
- jobs [options] jobID

### OPTIONS

* -l 
  * Show process id’s in addition to the normal information.
* -p
  * Show process id’s only.
* -n
  * Show only processes that have changed status since the last notification are printed.
* -r
  * Restrict output to running jobs only.
* -s
  * Restrict output to stopped jobs only.
* -x
  * COMMAND is run after all job specifications that appear in ARGS have been replaced with the process ID of that job’s process group leader.

### EXAMPLES

Before you start using jobs command, you need to start couple of jobs on your system. Type the following commands to start jobs:

```bash
xeyes &
gnome-calculator &
gedit fetch-stock-prices.py &
```

Finally, run ping command in foreground:

```bash
ping www.cyberciti.biz
```

To suspend ping command job hit the Ctrl-Z key sequence.

To display the status of jobs in the current shell, enter:

```bash
$ jobs
[1]   7895 Running                 gpass &
[2]   7906 Running                 gnome-calculator &
[3]-  7910 Running                 gedit fetch-stock-prices.py &
[4]+  7946 Stopped                 ping cyberciti.biz
```

To display the process ID or jobs for the job whose name begins with “p,” enter:

```bash
$ jobs -p %p
[4]-  Stopped                 ping cyberciti.biz
```

To show process IDs in addition to the normal information

- Pass the -l(lowercase L) option to jobs command for more information about each job listed, run:
- Info in sequence is : JobID, ProcessId, Status, Job

```bash
$ jobs -l
[1]  + 47274 suspended  ping google.com
```

To list only processes that have changed status since the last notification

- First, start a new job as follows:

```bash
$ sleep 100 &
```

- Now, only show jobs that have stopped or exited since last notified, type:

```bash
$ jobs -n
[5]-  Running                 sleep 100 &
```

Display lists process IDs (PIDs) only
- Pass the -p option to jobs command to display PIDs only:

```bash
$ jobs -p
7895
7906
7910
7946
7949
```

A note about /usr/bin/jobs and shell builtin
- Type the following type command to find out whether jobs is part of shell, external command or both:

```bash
$ type -a jobs
jobs is a shell builtin
jobs is /usr/bin/jobs
```

In almost all cases you need to use the jobs command that is implemented as a BASH/KSH/POSIX shell built-in. 
The /usr/bin/jobs command can not be used in the current shell. The /usr/bin/jobs command operates in a different 
environment and does not share the parent bash/ksh’s shells understanding of jobs. 