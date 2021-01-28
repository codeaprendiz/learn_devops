## passwd


### NAME

passwd - update userâs authentication tokens

### SYNOPSIS

> passwd  [-k] [-l]  [-u [-f]] [-d] [-n mindays] [-x maxdays] [-w warndays] [-i inactivedays] [-S] [--stdin] [username]

### DESCRIPTION

The passwd utility is used to update userâs authentication token(s).

This task is achieved through calls to the Linux-PAM and Libuser API.   Essentially, it initializes itself as a "passwd" service with Linux-PAM and utilizes configured password modules to authenticate and  then update a userâs password.

### EXAMPLES

To change the password for current user

```bash
$ passwd
```
