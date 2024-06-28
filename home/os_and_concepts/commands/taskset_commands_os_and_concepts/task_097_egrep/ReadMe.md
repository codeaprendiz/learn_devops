# egrep

- [egrep](https://man.freebsd.org/cgi/man.cgi)

## NAME

file pattern searcher

## Examples

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
.
```
