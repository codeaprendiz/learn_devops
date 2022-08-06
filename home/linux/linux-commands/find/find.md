## find

### NAME

find -- walk a file hierarchy

### SYNOPSIS

> find [-H | -L | -P] [-EXdsx] [-f path] path ... [expression]

>find [-H | -L | -P] [-EXdsx] -f path [path ...] [expression]

### DESCRIPTION

GNU find searches the directory tree rooted at each given starting-point by evaluating the given expression from left to right, according to the rules of precedence, until the outcome is known (the left hand side is false for and operations, true for or), at which point find moves on to the next file name.  
If no starting point is specified, `.' is assumed.

### OPTIONS

* -mtime n 
  * File's data was last modified n*24 hours ago.  
    All primaries which take a numeric argument allow the number to be preceded by a plus sign (``+'') or a minus sign (``-'').  
    A preceding plus sign means ``more than n'', a preceding minus sign means ``less than n'' and neither means ``exactly n''.
* -mmin n
   * File as data was last modified n minutes ago.
* -size n[cwbkMG]
  * File uses n units of space.  The following suffixes can be used:
    * b    
      * for 512-byte blocks (this is the default if no suffix is used)
    * c    
      * for bytes
    * w    
      * for two-byte words
    * k
      * for Kilobytes (units of 1024 bytes)
    * M    
      * for Megabytes (units of 1048576 bytes)
    * G    f
      * or Gigabytes (units of 1073741824 bytes)

* -type c 

  - File is of type c: 
    * b      block (buffered) special 
    * c      character (unbuffered) special 
    * d      directory 
    * p      named pipe (FIFO) 
    * f      regular file 
    * l      symbolic link 
    * s      socket 
    * D      door (Solaris) 

* -xdev
  * Do not descend directories on other filesystems.


EXAMPLES

* For example to show all the files in /app/endeca/PlatformServices/workspace/logs directory that have not been updated since last 25 days do

```bash
find /app/endeca/PlatformServices/workspace/logs -mtime +25 -exec ls -ltr {} \;
```

* For mmin

```bash
find $HOME/.BUILD_SCRIPTS_AREA/  -mmin -180 -name "*-bld.lock"|grep "$BLD_LOCK"|wc -l
```

* To find all the files which are greater than 100M size in $HOME path

```bash
[username@hostname admin-scripts]$ find $HOME -size +100M|grep "/logs/" 
/username/domains/test.prd.webDomain/servers/test/logs/test.out00006 
```

* To find the size of all files present in current directory which are greater than 100MB 

```bash
-bash-3.2$ find . -xdev -type f -size +100M -exec du -sh {} + 
374M    ./apache-tomcat-7.0.34/logs/catalina.out 
113M    ./sonar/sonarqube-5.5.zip 
107M    ./tmp-02082016/.jenkins/plugins.zip 
```



