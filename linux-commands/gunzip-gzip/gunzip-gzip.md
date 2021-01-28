## gunzip 

## gzip

### NAME

gzip -- compression/decompression tool using Lempel-Ziv coding (LZ77)

SYNOPSIS

> gzip [-cdfhkLlNnqrtVv] [-S suffix] file [file [...]]

> gunzip [-cfhkLNqrtVv] [-S suffix] file [file [...]]

> zcat [-fhV] file [file [...]]

### DESCRIPTION

The gzip program compresses and decompresses files using Lempel-Ziv coding (LZ77).  

If no files are specified, gzip will compress from standard input, or decompress to standard output.  

When in compression mode, each file will be replaced with another file with the suffix, set by the -S suffix option, added, if possible.

In decompression mode, each file will be checked for existence, as will the file with the suffix added.  Each file argument must contain a separate complete archive; when multiple files are indicated, each is decompressed in turn.

### OPTIONS

* -l, --list        
  * This option displays information about the file's compressed and uncompressed size, ratio, uncompressed name.  With the -v option, it also displays the compres- sion method, CRC, date and time embedded in the file.

### EXAMPLES

```bash
$ ls -ltr
total 72
-rw-r--r--  1 asr000p 74715970  5428 Dec 1 15:33 test.xml
$ gzip test.xml
$ ls -ltr
total 64
-rw-r--r--  1 asr000p 74715970  2030 Dec 1 15:33 test.xml.gz
$ gzip -l test.xml.gz 
  compressed uncompressed  ratio uncompressed_name
        2030         5428 62.6% test.xml
$ gunzip test.xml.gz 
$  ls -ltr
total 72
-rw-r--r--  1 asr000p 74715970  5428 Dec 1 15:33 test.xml
```
 

$ ls -ltr
total 72
-rw-r--r--  1 asr000p 74715970  5428 Dec 1 15:33 test.xml
$ gzip test.xml
$ ls -ltr
total 64
-rw-r--r--  1 asr000p 74715970  2030 Dec 1 15:33 test.xml.gz
$ gzip -l test.xml.gz 
  compressed uncompressed  ratio uncompressed_name
        2030         5428 62.6% test.xml
$ gunzip test.xml.gz 
$  ls -ltr
total 72
-rw-r--r--  1 asr000p 74715970  5428 Dec 1 15:33 test.xml