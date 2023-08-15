# adduser

- [adduser](https://linux.die.net/man/8/adduser)

useradd - create a new user or update default new user information

## Examples

- To create a new user named `username` with user ID 1030 and assigns it to the `root`` group, without setting a password or creating a home directory.

1. `-u 1030`: This flag specifies the user ID (UID) for the new user. In this case, the UID is set to `1030`.

2. `-G root`: This flag assigns the user to an existing group. In this case, the user is being assigned to the `root` group, which has a group ID (GID) of `0`.

3. `username`: This is the name of the new user being created.

4. `-D`: When invoked with only the -D option, useradd will display the current default values. When invoked with -D plus other options, useradd will update the default values for the specified options.

The `cat /etc/passwd | grep username` command then checks the `/etc/passwd` file for the new user's entry. The output confirms the successful creation of the user with the specified UID, and it being a member of the `root` group.

```bash
$ docker run -it --rm alpine:latest sh
/ $ adduser -D -u 1030 -G root username
/ $ cat /etc/passwd | grep username
username:x:1030:0:Linux User,,,:/home/username:/bin/ash
/ $ cat /etc/os-release
NAME="Alpine Linux"
VERSION_ID=3.18.3
```

- To create a new user named `username` with a user ID of `1050`, assigns the user to the group with group ID `0`, and sets their home directory to `/app/username`.

1. `--uid 1050`: This option specifies the user ID (UID) for the new user. Every user on a Linux system has a unique UID. Here, you're assigning the UID `1050` to the new user.

2. `--gid 0`: This option sets the group ID (GID) for the new user. In Linux, each user is associated with at least one group. The GID `0` typically corresponds to the `root` group. By using this option, you're making the new user a member of the `root` group.

3. `username`: This is the name of the new user you're creating. In this case, the new user will be named `username`.

4. `--home /app/username`: This option sets the home directory for the new user. The home directory is the default directory the user is placed into upon logging in. Here, you're setting the home directory of the new user to `/app/username`.

```bash
$ docker run -it --rm debian sh
$ adduser --uid 1050 --gid 0 username --home /app/username
.
. ## Fill the values on prmpt

$ cat /etc/passwd | grep username
username:x:1050:0:username,x,x,x,x:/app/username:/bin/bash

$ cat /etc/os-release
PRETTY_NAME="Debian GNU/Linux 12 (bookworm)"
VERSION_ID="12"
```
