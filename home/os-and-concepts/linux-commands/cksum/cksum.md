## cksum

### NAME     
cksum, sum -- display file checksums and block counts

### SYNOPSIS
> cksum [-o 1 | 2 | 3] [file ...]

> sum [file ...]


### DESCRIPTION
The cksum utility writes to the standard output three whitespace separated fields for each input file.  These fields are a checksum CRC, the total number of octets in the file and the file name. If no file name is specified, the standard input is used and no file name is written.

NOTE: Simple checksums, such as those produced by the cksum tool, are useful only for detecting accidental data corruption. It's not meant to protect against malicious alteration of a file. It's been proven that an attacker could carefully make changes to a file that would produce an identical cksum checksum. Therefore, if you need to be absolutely certain that a file is identical to the original, use a more powerful method. 

```bash
$ cat testFile 
This is test File.
$ cksum testFile 
1130043953 19 testFile
$ nano testFile 
$ cat testFile 
This is test File.
.
$ cksum testFile 
3666249486 21 testFile
$ 
```