## rsync

### NAME

rsync - faster, flexible replacement for rcp

### SYNOPSIS

> rsync [OPTION]... SRC [SRC]... DEST

> rsync [OPTION]... SRC [SRC]... [USER@]HOST:DEST

> rsync [OPTION]... SRC [SRC]... [USER@]HOST::DEST

> rsync [OPTION]... SRC [SRC]... rsync://[USER@]HOST[:PORT]/DEST

> rsync [OPTION]... SRC

> rsync [OPTION]... [USER@]HOST:SRC [DEST]

> rsync [OPTION]... [USER@]HOST::SRC [DEST]

> rsync [OPTION]... rsync://[USER@]HOST[:PORT]/SRC [DEST]

### DESCRIPTION

rsync  is a program that behaves in much the same way that rcp does, but has many more options and uses the rsync remote-update protocol to greatly speed up file transfers when the destination file is being updated.

The rsync remote-update protocol allows rsync to transfer just the differences between two sets of files across the network connection, using an efficient checksum-search algorithm described in the technical report that accompanies this package.

Some of the additional features of rsync are:

* support for copying links, devices, owners, groups, and permissions
* exclude and exclude-from options similar to GNU tar
* a CVS exclude mode for ignoring the same files that CVS would ignore
* can use any transparent remote shell, including ssh or rsh
* does not require super-user privileges
* pipelining of file transfers to minimize latency costs
* support for anonymous or authenticated rsync daemons (ideal for mirroring)

OTHER Description

It efficiently copies and sync files to or from a remote system.

Supports copying links, devices, owners, groups and permissions.

It’s faster than scp (Secure Copy) because rsync uses remote-update protocol which allows to transfer just the differences between two sets of files. First time, it copies the whole content of a file or a directory from source to destination but from next time, it copies only the changed blocks and bytes to the destination.

Rsync consumes less bandwidth as it uses compression and decompression method while sending and receiving data both ends.
 

OPTIONS

* -v : verbose

* -r : copies data recursively (but don’t preserve timestamps and permission while transferring data

* -a : archive mode, archive mode allows copying files recursively and it also preserves symbolic links, file permissions, user & group ownerships and timestamps

* -z : compress file data

* -h : human-readable, output numbers in a human-readable format

* -u,  
  *   --update skip files that are newer on the receiver
  *  --inplace update destination files in-place
  *  --append append data onto shorter files

* -r,  --recursive
       This tells rsync to copy directories recursively.
* -p, --perms

  * This option causes the receiving rsync to set the destination permissions to be the same as the source permissions.  (See also the --chmod option for a way to modify what rsync considers to be the source permissions.)
  * When this option is off, permissions are set as follows:
    * Existing  files (including  updated files) retain their existing permissions, though the --executability option might change just the execute permission for the file.
    * New files get their "normal" permission bits set to the source file's permissions masked with the receiving end's umask setting, and their special permission bits disabled except in the case where a new directory inherits a setgid bit from its parent directory.
 
* -g, --group
  * This option causes rsync to set the group of the destination file to be the same as the source file.  If the receiving program is not running as the super-user (or if --no-super was specified), only  groups that the invoking user on the receiving side is a member of will be preserved. Without this option, the group is set to the default group of the invoking user on the receiving side.
* -t, --times
  * This tells rsync to transfer modification times along with the files and update them on the remote system.  Note that if this option is not used, the optimization that excludes files that have not been modified cannot be effective; in other words, a missing -t or -a will cause the next transfer to behave as if it used -I, causing all files to be updated (though the rsync algorithm will make the update fairly efficient if the files haven't actually changed, you're much better off using -t).

### EXAMPLES

This following command will sync a single file on a local machine from one location to another location. Here in this example, a file name backup.tar needs to be copied or synced to /tmp/backups/ folder.

```bash
[root@tecmint]# rsync -zvh backup.tar /tmp/backups/
created directory /tmp/backups
backup.tar
sent 14.71M bytes  received 31 bytes 3.27M bytes/sec
total size is 16.18M  speedup is 1.10
```

This command will sync a directory from a local machine to a remote machine. For example: There is a folder in your local computer “rpmpkgs” which contains some RPM packages and you want that local directory’s content send to a remote server, you can use following command.

```bash
[root@tecmint]$ rsync -avz rpmpkgs/ root@192.168.0.101:/home/
root@192.168.0.101's password:
sending incremental file list
./
httpd-2.2.3-82.el5.centos.i386.rpm
mod_ssl-2.2.3-82.el5.centos.i386.rpm
nagios-3.5.0.tar.gz
nagios-plugins-1.4.16.tar.gz
sent 4993369 bytes  received 91 bytes 399476.80 bytes/sec
total size is 4991313  speedup is 1.00
```

To specify a protocol with rsync you need to give “-e” option with protocol name you want to use. Here in this example, We will be using “ssh” with “-e” option and perform data transfer.

```bash
[root@tecmint]# rsync -avzhe ssh root@192.168.0.100:/root/install.log /tmp/
root@192.168.0.100's password:
receiving incremental file list
install.log
sent 30 bytes  received 8.12K bytes  1.48K bytes/sec
total size is 30.74K  speedup is 3.77
```

To show the progress while transferring the data from one machine to a different machine, we can use ‘–progress’ option for it. It displays the files and the time remaining to complete the transfer.

```bash
[root@tecmint]# rsync -avzhe ssh --progress /home/rpmpkgs root@192.168.0.100:/root/rpmpkgs
```

Here in this example, rsync command will include those files and directory only which starts with ‘R’ and exclude all other files and directory.

```bash
[root@tecmint]# rsync -avze ssh --include 'R*' --exclude '*' root@192.168.0.101:/var/lib/rpm/ /root/rpm
```

Automatically delete source files after complete successfull transfer.


```bash
[root@tecmint]# rsync --remove-source-files -zvh backup.tar /tmp/backups/
```

