## jstack

### NAME

jstack - stack trace

### SYNOPSIS

> jstack [ option ] pid

> jstack [ option ] executable core

> jstack [ option ] [server-id@]remote-hostname-or-IP

### DESCRIPTION

jstack  prints Java  stack traces of Java threads for a given Java process or core file or a remote debug server. For each Java frame, the full class name, method name, 'bci' (byte code index) and line number, if available, are printed. 

### PARAMETERS

* pid            
  * process id for which the stacktrace is to be printed.  The process must be a Java process. To get a list of Java processes running on a machine, jps may be used.

* executable     
  * Java executable from which the core dump was produced.

* core           
  * core file for which the stack trace is to be printed.

* remote-hostname-or-IP
  * remote debug server's hostname or IP address.

* server-id      
  * optional unique id, if multiple debug servers are running on the same remote host.

### OPTIONS

* -m             
  * prints mixed mode (both Java and native C/C++ frames) stack trace.
  
```bash
$ pid=1345
$ jstack $pid >jstack.PID.$pid.TIMESTAMP.$(date +%H%M%S.%N) 
```
