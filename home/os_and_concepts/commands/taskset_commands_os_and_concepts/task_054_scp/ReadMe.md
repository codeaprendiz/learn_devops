# scp

## NAME

scp -- secure copy (remote file copy program)

## OPTIONS

* -r
  * Recursively copy entire directories.  Note that scp follows symbolic links encountered in the tree traversal.
  
```bash
scp -r app@10.117.157.66:/app/jboss-eap-6.4.0/jboss-as/standalone/configuration/fileName .
scp -r fileName app@10.117.140.110:/app/jboss-eap-6.4.0/jboss-as/standalone/configuration/
```
