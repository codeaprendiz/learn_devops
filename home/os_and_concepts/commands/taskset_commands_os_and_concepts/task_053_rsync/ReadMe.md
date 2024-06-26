# rsync

- [rsync](#rsync)
  - [NAME](#name)
  - [EXAMPLES](#examples)
    - [`-z` | compress | `-v` | verbose | `-h` | human-readable](#-z--compress---v--verbose---h--human-readable)
    - [`-a` | archive | remote server](#-a--archive--remote-server)
    - [`-e` | specify protocol | ssh | remote server](#-e--specify-protocol--ssh--remote-server)
    - [`--progress` | show progress | remote server](#--progress--show-progress--remote-server)
    - [`--remove-source-files` | delete source files](#--remove-source-files--delete-source-files)
    - [`--include` | `--exclude` | `--filter`](#--include----exclude----filter)

## NAME

rsync - faster, flexible replacement for rcp

## EXAMPLES

### `-z` | compress | `-v` | verbose | `-h` | human-readable

This following command will sync a single file on a local machine from one location to another location. Here in this example, a file name backup.tar needs to be copied or synced to /tmp/backups/ folder.

- `-z`: Enables compression for the data during the transfer.
- `-h`: Displays file sizes in a human-readable format (e.g., K, M, G).

```bash
rsync -zvh backup.tar /tmp/backups/
```

Output

```bash
created directory /tmp/backups
backup.tar
sent 14.71M bytes  received 31 bytes 3.27M bytes/sec
total size is 16.18M  speedup is 1.10
```

<br>

### `-a` | archive | remote server

This command will sync a directory from a local machine to a remote machine. For example: There is a folder in your local computer “rpmpkgs” which contains some RPM packages and you want that local directory’s content send to a remote server, you can use following command.

- `-a`: Archive mode; preserves filesystem attributes, performs recursive copying.

```bash
rsync -avz rpmpkgs/ root@192.168.0.101:/home/
```

Output

```bash
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

<br>

### `-e` | specify protocol | ssh | remote server

To specify a protocol with rsync you need to give “-e” option with protocol name you want to use. Here in this example, We will be using “ssh” with “-e” option and perform data transfer.

```bash
rsync -avzhe ssh root@192.168.0.100:/root/install.log /tmp/
```

Output

```bash
root@192.168.0.100's password:
receiving incremental file list
install.log
sent 30 bytes  received 8.12K bytes  1.48K bytes/sec
total size is 30.74K  speedup is 3.77
```

<br>

### `--progress` | show progress | remote server

To show the progress while transferring the data from one machine to a different machine, we can use ‘–progress’ option for it. It displays the files and the time remaining to complete the transfer.

```bash
rsync -avzhe ssh --progress /home/rpmpkgs root@192.168.0.100:/root/rpmpkgs
```

<br>

### `--remove-source-files` | delete source files

Automatically delete source files after complete successfull transfer.

```bash
rsync --remove-source-files -zvh backup.tar /tmp/backups/
```

<br>

### `--include` | `--exclude` | `--filter`

[stackoverflow.com](https://stackoverflow.com/questions/13713101/rsync-exclude-according-to-gitignore-hgignore-svnignore-like-filter-c)

- `--include`=`**.gitignore`: Includes files named .gitignore in the transfer, even if other rules might exclude them.
- `--exclude`=`/.git`: Excludes the .git directory located at the root of the source directory.
- `--delete-after`: Deletes files in the destination directory that are not in the source after the transfer.

```bash
rsync -arvh "${SYNC_FROM_DIR_THAT_MUST_NOT_CHANGE}/" "${SYNC_TO_DIR_THAT_WILL_CHANGE}/" --include='**.gitignore' --exclude='/.git' --filter=':- .gitignore' --delete-after
```
