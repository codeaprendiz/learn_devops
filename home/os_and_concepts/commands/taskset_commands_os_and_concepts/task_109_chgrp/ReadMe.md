# chgrp

- [chgrp](https://man7.org/linux/man-pages/man1/chgrp.1.html)

## Examples

### To change the group ownership of `/some/directory` and everything inside it to the root group

```bash
$ chgrp -R 0 /some/directory
.
```

- `chgrp`: This command changes the group ownership of files or directories.
- `-R`: This flag makes the command recursive, so it will apply to the directory and all its subdirectories and files.
- `0`: This is the group ID for the root group.
- `/some/directory`: This is the target directory on which the command is executed.
