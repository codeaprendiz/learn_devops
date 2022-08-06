## mkdir

### NAME

mkdir -- make directories

### SYNOPSIS

> mkdir [-pv] [-m mode] directory_name …

### DESCRIPTION

The mkdir utility creates the directories named as operands, in the order specified, using mode rwxrwxrwx (0777) as modified by the current umask(2).

### OPTIONS

The options are as follows:

* -m 
  * mode Set the file permission bits of the final created directory to the specified mode.  The mode argument can be in any of the formats specified to the chmod(1) command. If a symbolic mode is specified, the operation characters ``+'' and ``-'' are interpreted relative to an initial mode of ``a=rwx''.

* -p      
  * Create intermediate directories as required.  If this option is not specified, the full path prefix of each operand must already exist.  On the other hand, with this option specified, no error will be reported if a directory given as an operand already exists.  Intermediate directories are created with permission bits of rwxrwxrwx (0777) as modified by the current umask, plus write and search permission for the owner.

* -v      
  * Be verbose when creating directories, listing them as they are created.

* The user must have write permission in the parent directory.

```bash
$ mkdir -p /app/ankit/anything
```