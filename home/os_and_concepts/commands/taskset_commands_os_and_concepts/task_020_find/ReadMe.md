# find

## NAME

find -- walk a file hierarchy

## DESCRIPTION

GNU find searches the directory tree rooted at each given starting-point by evaluating the given expression from left to right, according to the rules of precedence, until the outcome is known (the left hand side is false for and operations, true for or), at which point find moves on to the next file name.  
If no starting point is specified, `.' is assumed.

## OPTIONS

* -mtime n
  * File's data was last modified n*24 hours ago.  
    All primaries which take a numeric argument allow the number to be preceded by a plus sign (``+'') or a minus sign (``-'').  
    A preceding plus sign means `more than n'', a preceding minus sign means` less than n'' and neither means ``exactly n''.
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
  * File is of type c:
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

## EXAMPLES

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

* Find all the files in current directory which are older than 1 month

```bash
$ find ./ -maxdepth 1 -type f -mtime +30 -print 
.
$ find ./ -maxdepth 1 -type f -mtime +30 
.
```

* Move the files older than 30 days to a particular directory

```bash
$ mkdir tmp
.
$ find ./ -maxdepth 1 -type f -mtime +30 -exec mv -t ./tmp/ {} + 
.
$ rm -rf tmp
.
```

* To find specific pom files and zip them into a file

```bash
$ find . -name Build-2019-03-09-23-38-pom-090319.xls -o -name Build-2019-03-12-23-05-pom-120319.xls -o -name Build-2019-03-13-07-46-pom-130319.xls|xargs zip -r 123.zip
.
```

* To find all the files of size greater than 1000M and print their sizes

```bash
find /apps/ -xdev -type f -size +1000M -exec du -sh {} + 
.
```

* To print all the files with size greater than 1G

```bash
$ find /apps/ap_frm/servers/apache-tomcat-8.5.38_pfm/logs/ -size +1G -type f -print
.
```

* To find all files with specific extension greater than 100MB, not been modified since last 3 days from current path

```bash
$ find . -size +100M -mtime +3 -type f \( -name "*.log" -o -name "*.txt" -o -name "*.out" \)
.
```

* To print all *.pomxml files containing the keyword `<artifactId>ns-exports-interfaces</artifactId>`

```bash
$ find . -name "*pom.xml" -exec egrep -n -A 2 "<artifactId>ns-exports-interfaces</artifactId>" '{}' \; -print
.
```

* To print all *.xml files containing keyword "insert into gen_mst_rpt" except the ones with "insert into gen_mst_rpt_param"

```bash
$ find . -name "*xml" -exec egrep -n -A 2 "*insert into gen_mst_rpt *" -v "*insert into gen_mst_rpt_param*" '{}' \; -print 
.
```

* Example of customized case when we can check the SVN URLs

```bash
$ for i in `cat  ~/.BUILD_SCRIPTS_AREA/modules.full`; do svn info $i | grep URL; done | awk {'print $2'} 
.
```

* To check and print all the log files in path /apps/ap_frm/servers/apache-tomcat-8.5.38_pfm/logs/ which have not been modified since last 3 days and can be of type `*.log OR *.txt`

  * You can also remove all those files but BE VERY CAREFUL when you execute rm -rf instead of ls -ltrh

```bash
for j in `find /apps/ap_frm/servers/apache-tomcat-8.5.38_pfm/logs/ -mtime +3 -type f \( -name "*.log" -o -name "*.txt" -o -name "*.out" \)`;do echo $j; ls -ltrh $j; done;
```
