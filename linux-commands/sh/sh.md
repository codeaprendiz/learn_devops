## sh

### NAME

bash - GNU Bourne-Again SHell

### SYNOPSIS

> bash [options] [file]

### DESCRIPTION

Bash  is an sh-compatible command language interpreter that executes commands read from the standard input or from a file.  Bash also incorporates useful features from the Korn and C shells (ksh and csh).

Bash is intended to be a conformant implementation of the Shell and Utilities portion of the IEEE POSIX specification (IEEE Standard 1003.1).  Bash can be configured to be POSIX-conformant by default.

### OPTIONS

* -x file
  * True if file exists and is executable.
  
```bash
$ sh -x /app/nfs_mount1.sh > /app/nfs_mount1.out 2>&1
```