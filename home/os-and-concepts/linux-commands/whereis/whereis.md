## whereis

### NAME

whereis -- locate programs

### SYNOPSIS

> whereis [program ...]

### DESCRIPTION

The whereis utility checks the standard binary directories for the specified programs, printing out the paths of any it finds.

The path searched is the string returned by the sysctl(8) utility for the ``user.cs_path'' string.

whereis -  locate the binary, source, and manual page files for a command

```bash
whereis java
```
