## df

### NAME

df -- display free disk space


### SYNOPSIS

> df [-b | -h | -H | -k | -m | -g | -P] [-ailn] [-t] [-T type] [file | filesystem ...]

DESCRIPTION

The df utility displays statistics about the amount of free disk space on the specified filesystem or on the filesystem of which file is a part.  
Values are displayed in 512-byte per block counts. 
If neither a file or a filesystem operand is specified, statistics for all mounted filesystems are displayed (subject to the -t option below).

### OPTIONS

The following options are available:

* -a      
* -h      
    - "Human-readable" output.  
      Use unit suffixes: Byte, Kilobyte, Megabyte, Gigabyte, Terabyte and Petabyte in order to reduce the number of digits to three or less using base  2 for sizes.
* -T      
    - Only print out statistics for filesystems of the specified types. 
      More than one type may be specified in a comma separated list. 
* -k      
      Use 1024-byte (1-Kbyte) blocks, rather than the default.  
* -m      
      Use 1048576-byte (1-Mbyte) blocks rather than the default. 


### EXAMPLES

- Check the file system disk usage of current file system of logged in user

```bash
df -kh .
```

- Display information of all file system disk space usage

```bash
df -a
```

- Show disk space usage in human readable format

```bash
df -h
```

- Display information of /home file system

```bash
df -hT /home
```

- Display information of file system in bytes

```bash
df -k
```

- Display information of file system in mb

```bash
df -m
```

- Display information of file system in gb

```bash
df -h
```

