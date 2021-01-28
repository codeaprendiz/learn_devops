## head


### NAME

head -- display first lines of a file

### SYNOPSIS

> head [-n count | -c bytes] [file ...]

### DESCRIPTION

This filter displays the first count lines or bytes of each of the specified files, or of the standard input if no files are specified.  If count is omitted it defaults to 10.
If more than a single file is specified, each file is preceded by a header consisting of the string ``==> XXX <=='' where ``XXX'' is the name of the file.

**EXIT STATUS**

The head utility exits 0 on success, and >0 if an error occurs.

### EXAMPLES

```bash
$ echo "this is first line \n this is second \n this is third " > file
$ cat file
this is first line 
 this is second 
 this is third 
$ head -n 2 file
this is first line 
 this is second 
$
```
