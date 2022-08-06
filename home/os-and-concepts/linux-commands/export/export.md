## export

### NAME

builtin, !, %, ., :, @, {, }, alias, alloc, bg, bind, bindkey, break, breaksw, builtins, case, cd, chdir, command, complete, continue, default, dirs, do, done, echo, echotc, elif, else, end, endif, endsw, esac, eval, exec, exit, export, false, fc, fg, filetest, fi, for, foreach, getopts, glob, goto, hash, hashstat, history, hup, if, jobid, jobs, kill, limit, local, log, login, logout, ls-F, nice, nohup, notify, onintr, popd, printenv, pushd, pwd, read, readonly, rehash, repeat, return, sched, set, setenv, settc, setty, setvar, shift, source, stop, suspend, switch, telltc, test, then, time, times, trap, true, type, ulimit, umask, unalias, uncomplete, unhash, unlimit, unset, unsetenv, until, wait, where, which, while -- shell built-in commands

### SYNOPSIS

> builtin [-options] [args ...]

### DESCRIPTION

Shell builtin commands are commands that can be executed within the running shell's process. 

The export command is one of the bash shell BUILTINS commands, which means it is part of your shell. 

In general, the export command marks an environment variable to be exported with any newly forked child processes and thus it allows a child process to inherit all marked variables.

### OPTIONS

* -p
    * List of all names that are exported in the current shell
* -n
    * Remove names from export list
* -f
    * Names are exported as functions

### EXAMPLES

- To export and add new executable in PATH

```bash
unzip /app/apache-maven-3.5.3.zip -d /app; chown -R app:app /app; export PATH=$PATH:/app/apache-maven-3.5.3/bin 
```

- Think over the following example:

```bash
$ a=domain.com
$ echo $a
domain.com
$ bash
$ echo $a
``` 

Line 1: new variable called "a" is created to contain string "domain.com"

Line 2: we use echo command to print out a content of the variable "a"

Line 3: we have created a new child bash shell

Line 4: variable "a" no longer have any values defined

From the above we can see that any new child process forked from a parent process by default does not inherit parent's variables. 

This is where the export command comes handy. 

- What follows is a new version of the above example using the export command:

```bash
$ a=domain.com
$ echo $a
domain.com
$ export a
$ bash
$ echo $a
domain.com
```

On the line 3 we have now used the export command to make the variable "a" to be exported when a new child process is created. 

As a result the variable "a" still contains the string "domain.com" even after a new bash shell was created. 

It is important to note that, in order to export the variable "a" to be available in the new process, the process must be forked from the parent process where the actual variable was exported.