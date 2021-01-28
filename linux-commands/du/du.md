## du

### NAME

du -- display disk usage statistics

### SYNOPSIS

> du [-H | -L | -P] [-a | -s | -d depth] [-c] [-h | -k | -m | -g] [-x] [-I mask] [file ...]

### DESCRIPTION

The du utility displays the file system block usage for each file argument and for each directory in the file hierarchy rooted in each directory argument.  

If no file is specified, the block usage of the hierarchy rooted in the current directory is displayed.

### OPTIONS

* -g      
    * Display block counts in 1073741824-byte (1-Gbyte) blocks.
* -k      
    * Display block counts in 1024-byte (1-Kbyte) blocks.
* -m     
    * Display block counts in 1048576-byte (1-Mbyte) blocks.
* -a      
    * Display an entry for each file in a file hierarchy.
* -h, --human-readable
    * print sizes in human readable format (e.g., 1K 234M 2G)


### EXAMPLE

- To get filesize of all contents of current dir

```bash
-bash-3.2$ ls | xargs du -sh
```

- Human readable

```bash
[username@hostname ~]$ du -h
96K     admin-scripts
4.0K    claims.dll.xml
6.5G    domains
4.0K    info.txt
4.0K    JMSFilestore-Core
2.1M    JMSFilestore-mis
```

- With -a option

```bash
du -a Certificates/
2224 Certificates//UC-5QGFP1U1.pdf
2216 Certificates//UC-B72CYCVK.pdf
2216 Certificates//UC-SNGUC41Q.pdf
6656 Certificates/
```
