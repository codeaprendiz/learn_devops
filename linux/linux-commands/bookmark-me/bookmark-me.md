
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

### kubectl
Start a busy box container anywhere and login to debugging
```bash
$ kubectl run -i --tty busybox --image=busybox --restart=Never -- sh
```

### kops

```bash
# validating cluster without setting environment variables
export KUBECONFIG=~/workspace/kops/_kube/dev/kubeconfig
AWS_ACCESS_KEY_ID=<aws_access_key> AWS_SECRET_ACCESS_KEY=<aws_secret_key> kops validate cluster --wait 10m --state="s3://my-kops-bucket-v1" --name=k8.mydomain.com

## creating cluster
bucket_name=devops-test-company
export AWS_SECRET_KEY=<aws_secret_key>
export AWS_ACCESS_KEY=<aws_access_key>
aws s3api create-bucket --bucket ${bucket_name} --region us-east-1
aws s3api put-bucket-versioning --bucket ${bucket_name} --versioning-configuration Status=Enabled
export KOPS_CLUSTER_NAME=k8.mydomain.com
export KOPS_STATE_STORE=s3://${bucket_name}
kops create cluster --node-count=1 --node-size=t3.medium --master-count=1 --master-size=t3.medium --zones=us-east-1a --name=${KOPS_CLUSTER_NAME} --yes
kops validate cluster --wait 10m

## updating instance size
kops get instancegroups
## edit the size of instance group and save the file
kops edit ig nodes-us-east-1a
kops get instancegroups
kops update cluster --name=${KOPS_CLUSTER_NAME}
kops update cluster --name=${KOPS_CLUSTER_NAME} --yes
kops rolling-update cluster --name=${KOPS_CLUSTER_NAME}
kops rolling-update cluster --name=${KOPS_CLUSTER_NAME} --yes
kops get instancegroups

## updating the number of instances
kops edit ig nodes-us-east-1a
## edit the minSize and maxSize
kops get instancegroups      
kops update cluster --name=${KOPS_CLUSTER_NAME}
kops update cluster --name=${KOPS_CLUSTER_NAME} --yes
```

### mongo

```bash
$ mongo -u username -p password mongodb-host.company.com:27017/admin
```


### mongorestore

Restoring the mongodump back into mongodb database

- `standalone-complete-host-1616062771.gzip` includes the complete backup including all the databases.

- `--nsInclude` include only these databases.

- `--drop` drop the existing collections if exist

- Ensuring we are 
```bash
$ uri_complete=mongodb://username:password@mongodbhost.company.com:27017/admin:27017/admin

$ mongorestore --uri=$uri_complete -v --gzip --archive=standalone-complete-host-1616062771.gzip --nsInclude="module-*" --nsInclude="cli*" --numInsertionWorkersPerCollection=15 --bypassDocumentValidation --drop --preserveUUID --convertLegacyIndexes
```

### mysql

Connecting to mysql db

```bash
$ mysql -h<hostname> -u<username> -p<password> 
```

### mysqldump

Taking the mysqldump

```bash
mysqldump --databases <database-name>  --master-data=2 --single-transaction --order-by-primary -r filename.sql -h <hostname> -u <username> -p
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

### ssh-keygen

To create your keys

```bash
$ ssh-keygen -q -t rsa -f key.pem -C key -N ''
$ ls
key.pem     key.pem.pub

```
