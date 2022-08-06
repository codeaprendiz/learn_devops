## dir


### NAME

basename, dirname -- return filename or directory portion of pathname


### SYNOPSIS

> basename string [suffix]

> basename [-a] [-s suffix] string [...]

> dirname string

### DESCRIPTION

The basename utility deletes any prefix ending with the last slash `/` character present in string (after first stripping trailing slashes), and a suffix, if given.  

The suffix is not stripped if it is identical to the remaining characters in string. 

The resulting filename is written to the standard output. 

The dirname utility deletes the filename portion, beginning with the last slash `/` character to the end of string (after first stripping trailing slashes), and writes the result to the standard output.


### EXAMPLES

The following line sets the shell variable FOO to /usr/bin.

```bash
FOO=`dirname /usr/bin/trail`
```
