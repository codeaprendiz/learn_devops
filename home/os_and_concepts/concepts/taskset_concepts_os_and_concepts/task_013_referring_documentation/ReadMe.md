# How to use the documentation

<br>

## Use the --help flag

```$ ls --help
Usage: ls [OPTION]... [FILE]...
List information about the FILEs (the current directory by default).
.
.
```

<br>

## Refer the man page

```bash
$ man ls --no-pager
```


<br>

## apropos


- To find commands related to `directory`

```bash
# https://superuser.com/questions/346703/linux-apropos-command-always-returns-nothing-appropriate

$ sudo mandb

$ apropos directory
basename (1)         - strip directory and suffix from filenames
bindtextdomain (3)   - set directory containing message catalogs
chroot (8)           - run command or interactive shell with special root directory
dbus-cleanup-sockets (1) - clean up leftover sockets in a directory
depmod.d (5)         - Configuration directory for depmod
dir (1)              - list directory contents
finalrd (1)          - final runtime directory generator for shutdown
find (1)             - search for files in a directory hierarchy
git-clone (1)        - Clone a repository into a new directory
git-mv (1)           - Move or rename a file, a directory, or a symlink
git-stash (1)        - Stash the changes in a dirty working directory away
grub-macbless (8)    - bless a mac file/directory
grub-mknetdir (1)    - prepare a GRUB netboot directory.
helpztags (1)        - generate the help tags file for directory
ls (1)               - list directory contents
mklost+found (8)     - create a lost+found directory on a mounted Linux second extended file system
mktemp (1)           - create a temporary file or directory
modprobe.d (5)       - Configuration directory for modprobe
mountpoint (1)       - see if a directory or file is a mountpoint
ntfsls (8)           - list directory contents on an NTFS filesystem
pam_mkhomedir (8)    - PAM module to create users home directory
pwd (1)              - print name of current/working directory
pwdx (1)             - report current working directory of a process
readdir (3am)        - directory input parser for gawk
run-parts (8)        - run scripts or programs in a directory
update-info-dir (8)  - update or create index file from all installed info files in directory
vdir (1)             - list directory contents
```

- To find `config` file for `sudo-ldap`

```bash
$ apropos "sudo-ldap"
sudo-ldap.conf (5)   - sudo LDAP configuration
```