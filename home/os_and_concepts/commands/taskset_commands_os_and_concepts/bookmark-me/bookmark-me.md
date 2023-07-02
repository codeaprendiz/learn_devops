


### egrep













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



### resize2fs

```bash
root@host:/# lsblk
NAME        MAJ:MIN RM  SIZE RO TYPE MOUNTPOINT
nvme0n1     259:0    0   20G  0 disk
└─nvme0n1p1 259:1    0    8G  0 part /

root@host:/# sudo growpart /dev/nvme0n1 1
CHANGED: partition=1 start=2048 old: size=16775135 end=16777183 new: size=41940959 end=41943007

root@host:/# df -kh .
Filesystem      Size  Used Avail Use% Mounted on
/dev/root       7.7G  7.7G   44M 100% /

root@host:/# resize2fs /dev/root
resize2fs 1.45.5 (07-Jan-2020)
Filesystem at /dev/root is mounted on /; on-line resizing required
old_desc_blocks = 1, new_desc_blocks = 3
The filesystem on /dev/root is now 5242619 (4k) blocks long.

root@host:/# df -kh .
Filesystem      Size  Used Avail Use% Mounted on
/dev/root        20G  7.7G   12G  40% /
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

### vi

To search and replace globally in a file

```bash
:%s/search/replace/g
```

#### How to paste yaml in vi 

- When you try to paste yaml directly

```yaml
- name: install packages
  pip:
    name: openshift==0.11.2
  tags:
    - docker-image
    - full-deploy
    - code-deploy
```

- After pasting it in vi.  0_0

```bash
- name: install packages
    pip:
                name: openshift==0.11.2
                  tags:
                              - docker-image
                                    - full-deploy
                                          - code-deploy
```

- Turn off the auto-ident when you paste code in `exec` mode [reference link](https://stackoverflow.com/questions/2514445/turning-off-auto-indent-when-pasting-text-into-vim)

```bash
:set paste                                                                                                                                                                                                  
```

- Now go to insert mode and paste the yaml ( you should see `-- INSERT (paste) --` at the bottom)

```yaml
- name: install packages
  pip:
    name: openshift==0.11.2
  tags:
    - docker-image
    - full-deploy
    - code-deploy
```

- You can turn it back on 
