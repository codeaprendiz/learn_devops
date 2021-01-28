## chage

### NAME
chage - change user password expiry information

### SYNOPSIS

> chage [options] user

### OPTIONS

* -l, --list
  * Show account aging information.
  
### EXAMPLE

- To get the password expiry information of the current user using the system, you can use

```bash
chage -l $USER
```