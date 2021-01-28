## system

### NAME 

system - execute a shell command 

### SYNOPSIS 

> \#include <stdlib.h> int system(const char *command); 

### DESCRIPTION 

system() executes a command specified in command by calling /bin/sh -c command, and returns after the command has been completed. During execution of the command, SIGCHLD will be blocked, and SIGINT and SIGQUIT will be ignored. 
RETURN VALUE 

The value returned is -1 on error (e.g. fork() failed), and the return status of the command otherwise. This latter return status is in the format specified in wait(2). Thus, the exit code of the command will be WEXITSTATUS(status). In case /bin/sh could not be executed, the exit status will be that of a command that does exit(127). If the value of command is NULL, system() returns non-zero if the shell is available, and zero if not. system() does not affect the wait status of any other children. 

### EXAMPLES

In the following example for all the block files and all the pom.xml files, the ones which have svn status as "!" (as the svn status output will start with this symbol for some files) will be removed using the command 'svn rm $2'. And the ones which have svn status as '?' (as the svn status output will start with this symbol for some files) will be added using the command 'svn add $2'.

```bash
$ svn status |egrep "block$|pom.xml$"| awk '/^[!]/ { system("svn rm " $2) } /^[?]/ { system("svn add " $2) }'
```
