# find

<br>

## NAME

find -- walk a file hierarchy

- [find](#find)
  - [NAME](#name)
  - [EXAMPLES](#examples)
    - [All files in a directory that have not been updated since last 300 days | -mtime || tail](#all-files-in-a-directory-that-have-not-been-updated-since-last-300-days---mtime--tail)
    - [files that were last modified in last 180 mins | -mmin | names match the pattern | -name || grep | wc](#files-that-were-last-modified-in-last-180-mins---mmin--names-match-the-pattern---name--grep--wc)
    - [files greater than 100M size | -size](#files-greater-than-100m-size---size)
    - [find all files greater than 100MB and print their sizes | -size | -exec | -type f | -xdev || du](#find-all-files-greater-than-100mb-and-print-their-sizes---size---exec---type-f---xdev--du)
    - [find files older than 1 month | -mtime | -print | -maxdepth](#find-files-older-than-1-month---mtime---print---maxdepth)
    - [Move the files older than 30 days to a particular directory | -t | -exec | -maxdepth | -type f || mv](#move-the-files-older-than-30-days-to-a-particular-directory---t---exec---maxdepth---type-f--mv)
    - [To find specific pom files and zip them into a file | -o -name | logicl OR || xargs | zip](#to-find-specific-pom-files-and-zip-them-into-a-file---o--name--logicl-or--xargs--zip)
    - [To find all files with specific extension greater than 100MB, not been modified since last 3 days from current path | -size | -mtime | -type f | -name | -o](#to-find-all-files-with-specific-extension-greater-than-100mb-not-been-modified-since-last-3-days-from-current-path---size---mtime---type-f---name---o)
    - [To print all \*.pom.xml files containing the keyword | -exec | -print | -name | -exec || egrep](#to-print-all-pomxml-files-containing-the-keyword---exec---print---name---exec--egrep)
    - [To print all \*.xml files containing keyword "insert into gen\_mst\_rpt" except the ones with "insert into gen\_mst\_rpt\_param" || egrep](#to-print-all-xml-files-containing-keyword-insert-into-gen_mst_rpt-except-the-ones-with-insert-into-gen_mst_rpt_param--egrep)
    - [-mtime | -type f | -name | -o || for | do](#-mtime---type-f---name---o--for--do)
    - [Replace currentstring with newstring in all regular files in the current directory](#replace-currentstring-with-newstring-in-all-regular-files-in-the-current-directory)

<br>

## EXAMPLES

<br>

### All files in a directory that have not been updated since last 300 days | -mtime || tail

`-mtime` in the `find` command is used to search for files based on the number of days since they were last modified; `-mtime +300` finds files modified more than 300 days ago.

```bash
find home/os_and_concepts/commands/taskset_commands_os_and_concepts -mtime +300 -exec ls  {} \; | tail -n 2
```

Output

```bash
ReadMe.md
home/os_and_concepts/commands/taskset_commands_os_and_concepts/task_016_dos2unix/ReadMe.md
```

<br>

### files that were last modified in last 180 mins | -mmin | names match the pattern | -name || grep | wc

For mmin

```bash
find $HOME/.BUILD_SCRIPTS_AREA/  -mmin -180 -name "*-bld.lock" | grep "$BLD_LOCK" | wc -l
```

<br>

### files greater than 100M size | -size

To find all the files which are greater than 100M size in $HOME path

```bash
find $HOME -size +100M | grep "/logs/" 
```

Output

```bash
/username/domains/test.prd.webDomain/servers/test/logs/test.out00006 
```

<br>

### find all files greater than 100MB and print their sizes | -size | -exec | -type f | -xdev || du

To find the size of all files present in current directory which are greater than 100MB

- `-xdev`: Prevents `find` from traversing into directories that are on different file systems or devices.
- `-type f`: Restricts the search to regular files (not directories or other types of files).
- `-size +100M`: Searches for files larger than 100 megabytes.

```bash
find . -xdev -type f -size +100M -exec du -sh {} +
```

Output

```bash
374M    ./apache-tomcat-7.0.34/logs/catalina.out 
113M    ./sonar/sonarqube-5.5.zip 
107M    ./tmp-02082016/.jenkins/plugins.zip 
```

<br>

### find files older than 1 month | -mtime | -print | -maxdepth

Find all the files in current directory which are older than 1 month

- `-maxdepth 1`: Limits the search to the current directory and does not descend into subdirectories.
- `-type f`: Restricts the search to regular files (not directories or other types of files).
- `-mtime +30`: Searches for files that were last modified more than 30 days ago.
- `-print`: Outputs the full path of each file found that matches the criteria.

```bash
find ./ -maxdepth 1 -type f -mtime +30 -print 
```

<br>

### Move the files older than 30 days to a particular directory | -t | -exec | -maxdepth | -type f || mv

Move the files older than 30 days to a particular directory

- `-t`: Specifies the target directory where the files should be moved.

```bash
$ mkdir tmp
.
$ find ./ -maxdepth 1 -type f -mtime +30 -exec mv -t ./tmp/ {} + 
.
$ rm -rf tmp
.
```

<br>

### To find specific pom files and zip them into a file | -o -name | logicl OR || xargs | zip

- `-name Build-2019-03-09-23-38-pom-090319.xls -o -name Build-2019-03-12-23-05-pom-120319.xls -o -name Build-2019-03-13-07-46-pom-130319.xls`: Searches for files matching any of these specified names, with `-o` (logical OR) separating each name.
- `| xargs zip -r 123.zip`: Uses `xargs` to pass the found files as arguments to the `zip` command, which recursively (-r) adds these files to a ZIP archive named `123.zip`.

```bash
find . -name Build-2019-03-09-23-38-pom-090319.xls -o -name Build-2019-03-12-23-05-pom-120319.xls -o -name Build-2019-03-13-07-46-pom-130319.xls | xargs zip -r 123.zip
```

<br>

### To find all files with specific extension greater than 100MB, not been modified since last 3 days from current path | -size | -mtime | -type f | -name | -o

- `-size +100M`: Searches for files larger than 100 megabytes.
- `-mtime +3`: Searches for files that were last modified more than 3 days ago.
- `-type f`: Restricts the search to regular files (not directories or other types of files).
- `\( -name "*.log" -o -name "*.txt" -o -name "*.out" \)`: Groups the name conditions to search for files ending with `.log`, `.txt`, or `.out` using logical OR (`-o`).

```bash
find . -size +100M -mtime +3 -type f \( -name "*.log" -o -name "*.txt" -o -name "*.out" \)
```

<br>

### To print all *.pom.xml files containing the keyword | -exec | -print | -name | -exec || egrep

```bash
find . -name "*pom.xml" -exec egrep -n -A 2 "<artifactId>ns-exports-interfaces</artifactId>" '{}' \; -print
```

<br>

### To print all *.xml files containing keyword "insert into gen_mst_rpt" except the ones with "insert into gen_mst_rpt_param" || egrep

- `-name "*xml"`: Searches for files whose names end with `xml`.
- `-exec egrep -n -A 2 "*insert into gen_mst_rpt *" -v "*insert into gen_mst_rpt_param*" '{}' \;`: Executes the `egrep` command on each found file, searching for lines containing "insert into gen_mst_rpt" (displaying the line number and the two lines following it) but excluding lines containing "insert into gen_mst_rpt_param".
- `-print`: Prints the full path of each file that matches the `-name` condition and is processed by the `egrep` command.

```bash
find . -name "*xml" -exec egrep -n -A 2 "*insert into gen_mst_rpt *" -v "*insert into gen_mst_rpt_param*" '{}' \; -print 
```

<br>

### -mtime | -type f | -name | -o || for | do

- `find /apps/ap_frm/servers/apache-tomcat-8.5.38_pfm/logs/ -mtime +3 -type f \( -name "*.log" -o -name "*.txt" -o -name "*.out" \)`: Finds files in the specified directory that are older than 3 days (`-mtime +3`), are regular files (`-type f`), and match any of the specified extensions (`*.log`, `*.txt`, `*.out`).
- `for j in $( ... )`: Iterates over the list of files found by the `find` command.
- `do echo $j`: Prints the filename.
- `ls -ltrh $j`: Lists details of the file (`-l` for long format, `-t` for sorting by modification time, `-r` for reverse order, `-h` for human-readable file sizes).
- `done`: Ends the loop.

This command prints the filenames and their details for each file found that matches the criteria.

```bash
for j in $( find /apps/ap_frm/servers/apache-tomcat-8.5.38_pfm/logs/ -mtime +3 -type f \( -name "*.log" -o -name "*.txt" -o -name "*.out" \) );do echo $j; ls -ltrh $j; done;
```

<br>

### Replace currentstring with newstring in all regular files in the current directory

```bash
find . -type f -exec sed -i '' 's/currentstring/newstring/g' {} +
```
