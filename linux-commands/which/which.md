## which

### NAME

which -- locate a program file in the user's path

### SYNOPSIS

> which [-as] program ...

### DESCRIPTION

The which utility takes a list of command names and searches the path for each executable file that would be run had these commands actually been invoked.

Some shells may provide a builtin which command which is similar or identical to this utility.

### OPTIONS

* -a      
  * List all instances of executables found (instead of just the first one of each).
* -s      
  * No output, just return 0 if any of the executables are found, or 1 if none are found.

### EXAMPLES    

which - shows the full path of (shell) commands

```bash
which java
```
