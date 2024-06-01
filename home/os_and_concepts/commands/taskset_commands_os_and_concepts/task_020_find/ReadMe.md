# find

## NAME

find -- walk a file hierarchy

- [find](#find)
  - [NAME](#name)
  - [EXAMPLES](#examples)
    - [All files in a directory that have not been updated since last 300 days | -mtime](#all-files-in-a-directory-that-have-not-been-updated-since-last-300-days---mtime)
    - [files that were last modified in last 180 mins | -mmin | names match the pattern | -name](#files-that-were-last-modified-in-last-180-mins---mmin--names-match-the-pattern---name)
    - [files greater than 100M size | -size](#files-greater-than-100m-size---size)
    - [find all files greater than 100MB and print their sizes | -size | -exec | -type f | -xdev](#find-all-files-greater-than-100mb-and-print-their-sizes---size---exec---type-f---xdev)
    - [find files older than 1 month | -mtime | -print | -maxdepth](#find-files-older-than-1-month---mtime---print---maxdepth)
    - [Move the files older than 30 days to a particular directory](#move-the-files-older-than-30-days-to-a-particular-directory)

## EXAMPLES

### All files in a directory that have not been updated since last 300 days | -mtime

`-mtime` in the `find` command is used to search for files based on the number of days since they were last modified; `-mtime +300` finds files modified more than 300 days ago.

```bash
find home/os_and_concepts/commands/taskset_commands_os_and_concepts -mtime +300 -exec ls  {} \; | tail -n 2
```

Output

```bash
ReadMe.md
home/os_and_concepts/commands/taskset_commands_os_and_concepts/task_016_dos2unix/ReadMe.md
```

### files that were last modified in last 180 mins | -mmin | names match the pattern | -name

For mmin

```bash
find $HOME/.BUILD_SCRIPTS_AREA/  -mmin -180 -name "*-bld.lock" | grep "$BLD_LOCK" | wc -l
```

### files greater than 100M size | -size

To find all the files which are greater than 100M size in $HOME path

```bash
find $HOME -size +100M | grep "/logs/" 
```

Output

```bash
/username/domains/test.prd.webDomain/servers/test/logs/test.out00006 
```

### find all files greater than 100MB and print their sizes | -size | -exec | -type f | -xdev

To find the size of all files present in current directory which are greater than 100MB

```bash
find . -xdev -type f -size +100M -exec du -sh {} +
```

Output

```bash
374M    ./apache-tomcat-7.0.34/logs/catalina.out 
113M    ./sonar/sonarqube-5.5.zip 
107M    ./tmp-02082016/.jenkins/plugins.zip 
```

### find files older than 1 month | -mtime | -print | -maxdepth

Find all the files in current directory which are older than 1 month

```bash
find ./ -maxdepth 1 -type f -mtime +30 -print 
```

```bash
find ./ -maxdepth 1 -type f -mtime +30 
```

### Move the files older than 30 days to a particular directory 

Move the files older than 30 days to a particular directory

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
$ find . -name Build-2019-03-09-23-38-pom-090319.xls -o -name Build-2019-03-12-23-05-pom-120319.xls -o -name Build-2019-03-13-07-46-pom-130319.xls | xargs zip -r 123.zip
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
