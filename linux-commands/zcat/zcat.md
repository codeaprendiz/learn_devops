## zcat

### DESCRIPTION

zcat – Expands a compressed file to standard output

zcat uncompresses either a list of files on the command line or its standard input and writes the uncompressed data on standard output. zcat will uncompress files whether they have a .gz suffix or not.  

### SYNOPSIS

> zcat [ -f ] [ File … ]

### EXAMPLES

To view the contents of zipped file

```bash
$ cat file1.txt
abc
def
ghi
$ gzip file1.txt
$ zcat file1.txt.gz 
abc
def
ghi
```

Display the file content without worrying about whether it is compressed or not. When you are not sure whether a file is compressed or not, you can still view the file without worrying about it’s compression status as shown below.

```bash
zcat -f input-file
```