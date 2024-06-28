# chown

## NAME

chown -- change file owner and group

## DESCRIPTION

The chown utility changes the user ID and/or the group ID of the specified files.  Symbolic links named by arguments are silently left unchanged unless -h is used.

## OPTIONS

The options are as follows:

- `-R`
  - Change the user ID and/or the group ID for the file hierarchies rooted in the files instead of just the files themselves.
  
## EXAMPLES

### To change the ownership recursively

```bash
chown -R username:username /home/looker/.ssh/id_rsa.pub && chmod 644 /home/looker/.ssh/id_rsa.pub
.
```

### To change the owner and group of files and directories

```bash
$ chown -R 1001:0 /some/directory
.
```

- `-R`: This option makes the command recursive. This means the ownership changes will be applied not only to `/some/directory` itself but also to all of its subdirectories, sub-subdirectories, files within those directories, and so on.
- `1001:0`: This specifies the new owner and group for the files/directories:
  - `1001`: This is the user ID (UID) of the new owner. In this case, the user with UID `1001` will become the new owner.
  - `0`: This is the group ID (GID) of the new group. The `0` GID typically corresponds to the `root` group.
- `/some/directory`: This is the target directory where the ownership changes will be applied.

In essence, after executing this command, the user with UID `1001` will become the owner, and the `root` group (GID `0`) will become the group for the `/some/directory` and all its contents (due to the `-R` flag). This is a common operation in environments like OpenShift where containers might run with an arbitrary UID for security reasons but still need to have specific group permissions (often via the `root` group).
