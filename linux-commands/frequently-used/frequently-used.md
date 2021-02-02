
### truncating files

```bash
>/catalina.out
```

### du

To get all the large files with size greater than 1000MB

```bash
find . -xdev -type f -size +1000M -exec du -sh {} + 
```

To get large files with their time stamp 

```bash
find . -xdev -type f -size +100M -exec du -sh {} + | awk {'print $2'} | xargs ls -ltrh | grep *.out 
```

Find all the files in current directory which are older than 1 month 

```bash
find ./ -maxdepth 1 -type f -mtime +30 -print 
find ./ -maxdepth 1 -type f -mtime +30 
```

Move the files older than 30 days to a particular directory 

```bash
$ mkdir tmp 
$ find ./ -maxdepth 1 -type f -mtime +30 -exec mv -t ./tmp/ {} + 
$ rm -rf tmp
```


### egrep

To change all occurrences of 'AdminServer' with 'prdAdminServer'

```bash
$ egrep -rl "AdminServer" *| xargs sed -i 's/AdminServer/prdAdminServer/g' 
  
$ egrep -r "AdminServer" * 
bin/setDomainEnv.sh:    SERVER_NAME="AdminServer"  
 
$ egrep -rl "AdminServer" bin/setDomainEnv.sh | xargs sed -i 's/AdminServer/prdAdminServer/g' 
 
$ egrep -r "AdminServer" bin/setDomainEnv.sh 
        SERVER_NAME="prdAdminServer" 
```

To print all files containing keyword 'ns-exports-interfaces' except .svn, starting with Binary or Starting with ./out1.txt"

```bash
$ egrep "ns-exports-interfaces*" `find . -type f -print` | egrep -v ".svn|^Binary file|^./out1.txt"
```


### find

To find specific pom files and zip them into a file

```bash
find . -name Build-2019-03-09-23-38-pom-090319.xls -o -name Build-2019-03-12-23-05-pom-120319.xls -o -name Build-2019-03-13-07-46-pom-130319.xls|xargs zip -r 123.zip
```

To find all the files of size greater than 1000M and print their sizes

```bash
find /apps/ -xdev -type f -size +1000M -exec du -sh {} + 
```

To print all the files with size greater than 1G

```bash
find /apps/ap_frm/servers/apache-tomcat-8.5.38_pfm/logs/ -size +1G -type f -print
```

To find all files with specific extension greater than 100MB, not been modified since last 3 days from current path

```bash
find . -size +100M -mtime +3 -type f \( -name "*.log" -o -name "*.txt" -o -name "*.out" \)
```

To print all *.pomxml files containing the keyword "<artifactId>ns-exports-interfaces</artifactId>"

```bash
$ find . -name "*pom.xml" -exec egrep -n -A 2 "<artifactId>ns-exports-interfaces</artifactId>" '{}' \; -print
```

To print all *.xml files containing keyword "insert into gen_mst_rpt" except the ones with "insert into gen_mst_rpt_param"

```bash
$ find . -name "*xml" -exec egrep -n -A 2 "*insert into gen_mst_rpt *" -v "*insert into gen_mst_rpt_param*" '{}' \; -print 
```


### for

Example of customized case when we can check the SVN URLs

```bash
for i in `cat  ~/.BUILD_SCRIPTS_AREA/modules.full`; do svn info $i | grep URL; done | awk {'print $2'} 
```


To check and print all the log files in path /apps/ap_frm/servers/apache-tomcat-8.5.38_pfm/logs/ which have not been modified since last 3 days and can be of type *.log OR *.txt

You can also remove all those files but BE VERY CAREFUL when you execute rm -rf instead of ls -ltrh

```bash
for j in `find /apps/ap_frm/servers/apache-tomcat-8.5.38_pfm/logs/ -mtime +3 -type f \( -name "*.log" -o -name "*.txt" -o -name "*.out" \)`;do echo $j; ls -ltrh $j; done;
```

### nohup

To run the sql queries in background 

```bash
nohup sqlplus USERNAME/PASSWORD@DBNAME @/apps/home/dbfile.sql &
```

### ps

```bash
ps -p <pid> -o %cpu,%mem,cmd
```

To check which all Oracle Databases are running in the DB server

```bash
[username@hostname ~]$ ps -ef | grep pmon | grep oracle
oracle   23274     1  0 Aug19 ?        00:11:08 ora_pmon_db1
oracle   23689     1  0 Aug19 ?        00:12:12 ora_pmon_db2
```

### ssh

To login using the bastion server

```bash
$ ssh -o ProxyCommand="ssh -i private_key_to_login.pem -W %h:%p ubuntu@bastion.host.link" -i private_key_to_login.pem ubuntu@172.126.146.224 -vvvvv
```
