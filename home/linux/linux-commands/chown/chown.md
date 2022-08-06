## chown


### NAME
chown -- change file owner and group

### SYNOPSIS

> chown [-fhv] [-R [-H | -L | -P]] owner[:group] file …

> chown [-fhv] [-R [-H | -L | -P]] :group file …

### DESCRIPTION

The chown utility changes the user ID and/or the group ID of the specified files.  Symbolic links named by arguments are silently left unchanged unless -h is used.

### OPTIONS

The options are as follows:
* -R      
  * Change the user ID and/or the group ID for the file hierarchies rooted in the files instead of just the files themselves.
  
### EXAMPLES

- To change the ownership recursively.

```bash
chown -R username:username /home/looker/.ssh/id_rsa.pub && chmod 644 /home/looker/.ssh/id_rsa.pub
```  
