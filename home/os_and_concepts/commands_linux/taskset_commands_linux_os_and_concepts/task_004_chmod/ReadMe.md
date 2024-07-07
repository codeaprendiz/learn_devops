# chmod

## NAME

chmod -- change file modes or Access Control Lists

## EXAMPLES

```bash
chmod 644 /home/looker/.ssh/id_rsa.pub
.
```

### To recursively sets the group permissions of everything inside the `/test` directory (and the directory itself) to match the owner's permissions

```bash
$ chmod -R g=u /test
.
```

- `-R`: This flag makes the command recursive. This means the command will be applied not only to `/test` itself but also to all its subdirectories, sub-subdirectories, and so on, as well as all files within those directories.

- `g=u`: This is the key part of the command that specifies how permissions should be changed:
  - `g`: Represents the group's permissions.
  - `u`: Represents the user's (or owner's) permissions.
  - `=`: Sets the group's permissions to be the same as the user's permissions.
- So, `g=u` means "set the group's permissions to be the same as the user's permissions for the given file or directory.
- `/test`: This is the target directory on which the command is applied.

In a practical example, if there's a file inside `/test` with permissions `rwxr-----` (read, write, execute for the owner, and no permissions for the group and others), after executing the command, the file's permissions would change to `rwxrwx---` (giving read, write, execute permissions for both the owner and the group).

This operation is useful when you want to ensure that a group (often a special or system group) has the same access permissions as the owner of a file or directory.

### To add read, write, and conditional execute permissions for the group on the `/some/directory`` and all its contents

```bash
$ chmod -R g+rwX /some/directory
.
```

- `-R`: This option stands for "recursive." When specified, the command will apply the given permissions to the target directory and all its contents (including subdirectories and files).

- `g+rwX`: This is the key part where permissions are being modified:
  - `g`: Stands for "group." It indicates that the permission changes will apply to the group ownership of the file/directory.
  - `+`: This denotes that we're adding the permissions that follow.
  - `rw`: Stands for "read" and "write." So, we're adding read and write permissions for the group.
  - `X`: The capital "X" is a special permission in `chmod`. It stands for "execute/search only if the file is a directory or already has execute permission for some user." This means, for files, the execute permission is set only if the file already had some form of execute permission. For directories (which use the execute bit to mean "searchable"), the execute/search permission is always set.

- `/some/directory`: This is the target directory where the permissions will be applied.

So, the command `chmod -R g+rwX /some/directory` adds read, write, and conditional execute permissions for the group on the `/some/directory` and all its contents.
