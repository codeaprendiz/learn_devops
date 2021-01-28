## ps

### NAME

ps -- process status

### SYNOPSIS

> ps [-AaCcEefhjlMmrSTvwXx] [-O fmt | -o fmt] [-G gid[,gid...]] [-g grp[,grp...]] [-u uid[,uid...]] [-p pid[,pid...]] [-t tty[,tty...]] [-U user[,user...]]

> ps [-L]

### DESCRIPTION

The ps utility displays a header line, followed by lines containing information about all of your processes that have controlling terminals.

A different set of processes can be selected for display by using any combination of the -a, -G, -g, -p, -T, -t, -U, and -u options.  If more than one of these options are given, then ps will select all processes which are matched by at least one of the given options.

For the processes which have been selected for display, ps will usually display one line per process.  The -M option may result in multiple output lines (one line per thread) for some processes. By default all of these output lines are sorted first by controlling terminal, then by process ID.  The -m, -r, and -v options will change the sort order. If more than one sorting option was given, then the selected processes will be sorted by the last sorting option which was specified.

For the processes which have been selected for display, the information to display is selected based on a set of keywords (see the -L, -O, and -o options).  The default output format includes, for each process, the process' ID, controlling terminal, CPU time (including both user and system time), state, and associated command.


### OPTIONS

* -A     
  * Display information about other users' processes, including those without controlling terminals.

* -e
  * Identical to -A

* -f      
  * Display the uid, pid, parent pid, recent CPU usage, process start time, controlling tty, elapsed CPU usage, and the associated command.  If the -u option is also used, display the user name rather then the numeric uid. When -o or -O is used to add to the display following -f, the command field is not truncated as severely as it is in other formats.

* -o format       
  * user-defined format.
  * format is a single argument in the form of a blank-separated or comma-separated list, which offers a way to specify individual output columns. The recognized keywords are described in the STANDARD FORMAT SPECIFIERS section below. Headers may be renamed (ps -o pid,ruser=RealUser -o comm=Command) as desired. If all column headers are empty (ps -o pid= -o comm=) then the header line will not be output. Column width will increase as needed for wide headers; this may be used to widen up columns such as 
    WCHAN (ps -o pid,wchan=WIDE-WCHAN-COLUMN -o comm). Explicit width control (ps opid,wchan:42,cmd) is offered too. The behavior of ps -o pid=X,comm=Y varies with personality; output may be one column named "X,comm=Y" or two columns named "X" and "Y". Use multiple -o options when in doubt. Use the PS_FORMAT environment variable to specify a default as desired; DefSysV and DefBSD are macros that may be used to choose the default UNIX or BSD columns.
  
* -p pidlist      Select by PID.
  * This selects the processes whose process ID numbers appear in pidlist. Identical to p and --pid.
    

### EXAMPLES

It is used to get the process status.

set of options for viewing all the processes running on a system is

* Display information about other users' processes, including those without controlling terminals.
* Display the uid, pid, parent pid, recent CPU usage, process start time, controlling tty, elapsed CPU usage, and the associated command.
* less is a terminal program on Unix, Windows, and Unix-like systems used to view (but not change) the contents of a text file one screen at a time

```bash
ps -ef | less
```

The processes shown by ps can be limited to those belonging to any given user by piping the output through grep, a filter that is used for searching text. For example, processes belonging to a user with a username adam can be displayed with the following:

```bash
ps -ef | grep adam
```

-p, -o

```bash
$ ps -p 14491 -o %cpu,%mem,cmd
%CPU %MEM CMD
 0.0  0.4 /apps/resources/java/jdk1.7.0_15/bin/java -Xms512m -Xmx1024m -XX:MaxPermSize=1024m -jar slave.jar
```

-p selecting by pid

```bash
$ ps -p 14491 -o %cpu,%mem,cmd
%CPU %MEM CMD
 0.0  0.4 /apps/resources/java/jdk1.7.0_15/bin/java -Xms512m -Xmx1024m -XX:MaxPermSize=1024m -jar slave.jar
```
