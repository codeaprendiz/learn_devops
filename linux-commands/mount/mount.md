## mount

### NAME

mount -- mount file systems

### SYNOPSIS

> mount [-adfruvw] [-t lfs | external_type]

> mount [-dfruvw] special | mount_point

> mount [-dfruvw] [-o options] [-t lfs | external_type] special mount_point

### DESCRIPTION

The mount command calls the mount(2) system call to prepare and graft a special device or the remote node (rhost:path) on to the file system tree at the point mount_point, which must be a directory.  If either special or mount_point are not provided, the appropriate information is obtained via the getfsent(3) library routines.

The system maintains a list of currently mounted file systems.  If no arguments are given to mount, this list is printed.

### OPTIONS

* -o      
  * Options are specified with a -o flag followed by a comma separated string of options.  The following options are available:
  * force   
    * The same as -f; forces the revocation of write access when trying to downgrade a filesystem mount status from read-write to read-only.

  * -t lfs | external type
    * The argument following the -t is used to indicate the file system type.  There is no default local file system for use with mount. A type must be specified in order to mount a non-NFS filesystem.  The -t option can be used to indicate that the actions should only be taken on filesystems of the specified type. More than one type may be specified in a comma separated list.  The list of filesystem types can be prefixed with ``no'' to specify the filesystem types for which action should not be taken. For example, the mount command:
      > mount -a -t nonfs,hfs
    * mounts all filesystems except those of type NFS and HFS.
    * If the type is not one of the internally known types, mount will attempt to execute a program in /sbin/mount_XXX where XXX is replaced by the type name.  For example, nfs filesystems are mounted by the program /sbin/mount_nfs.

* -t nfs
  * This is used to mount nfs file system

* -o
  * -o vers=<num> to specify NFS protocol version.

* vers=<num[.num]>[-<num[.num]>]
  * NFS protocol version number - 2 for NFSv2, 3 for NFSv3 and 4 for NFSv4.  The default is to try version 3 first, and fall back to version 2 if the mount fails.

* server:/path directory
  * server is the fqdn of the server used for nfs shared
  * path is the ‘dir path’ in the server which will be mounted
  * directory is the ‘dir path’ in the local system which will be mounted to the remote path. 


### EXAMPLES

**Introduction**

  * A filesystem is a way that an operating system organizes files on a disk. These filesystems come in many different flavors depending on your specific needs. For Windows, you have the NTFS, FAT, FAT16, or FAT32 filesystems. For Macintosh, you have the HFS filesystem
  * In order to access a filesystem in Linux you first need to mount it. Mounting a filesystem simply means making the particular filesystem accessible at a certain point in the Linux directory tree. When mounting a filesystem it does not matter if the filesystem is a hard disk partition, CD-ROM, floppy, or USB storage device. You simply need to know the device name associated with the particular storage device and a directory you would like to mount it to.

**Seeing a list of mounted filesystems**

  * In order to determine what filesystems are currently being used type the command:
    ```bash
     $ mount
    ``` 
  * When you type this at a command prompt, this command will display all the mounted devices, the filesystem type it is mounted as, and the mount point. The mount point being local directory that is assigned to a filesystem during the process of mounting

**How to mount filesystems**

  * Before you can mount a filesystem to a directory, you should (NOT MUST)  be logged in as root (some filesystems can be mountable by a standard user) and the directory you want to mount the filesystem to must first exist.

**Another example**

  * As our first example, lets use a real world example of accessing your Windows files from a floppy in Linux.
  * In order to mount a device to a particular folder, that folder must exist. Many Linux distributions will contain a /mnt folder, or even a /mnt/floppy folder, that is used to mount various devices. If the folder that you would like to mount the device to exists, then you are all set. If not you need to create it like this:
    ```bash
    $ mkdir /mnt/floppy
    ```


  * This command will have now created a directory called /mnt/floppy. The next step would be to mount the filesystem to that folder or mount point.

```bash
$ mount -t msdos /dev/fd0 /mnt/floppy
```

  * You have now mounted an msdos filesystem, which is indicated by the -t (type) option. The device is recognized by the /mnt/floppy point. Now you can access MS-DOS formatted disks as you would any other directory.

  * -t lfs | external type
    * The argument following the -t is used to indicate the file system type.  There is no default local file system for use with mount. A type must be specified in order to mount a non-NFS filesystem.  The -t option can be used to indicate that the actions should only be taken on filesystems of the specified type. More than one type may be specified in a comma separated list.  The list of filesystem types can be prefixed with ``no'' to specify the filesystem types for which action should not be taken. For example, the mount command:
    * mount -a -t nonfs,hfs
  * mounts all filesystems except those of type NFS and HFS.
  
**To mount a CD-ROM:**

```bash
$ mount -t iso9660 /dev/cdrom /mnt/cdrom
```

  * Again this is a similar method as above to mount the CD-ROM.

**How to unmount a filesystem**

  * When you are done using a particular filesystem, you should unmount. The command to unmount a filesystem is the umount command.
  * When unmounting a filesystem you simply type umount followed by the mount point. For example:

```bash
$ umount /mnt/floppy
$ umount /mnt/cdrom
```

**To mount nsf shared locations we have to execute**

```bash
$ mkdir -p /home/looker/looker/models-share
$ chown -R looker:looker /home/looker/looker/models-share
$ chown looker:looker /home/looker/looker/models-share
$ mount -t nfs -o vers=3 dfw-nfs3-vs10.prod.com:/dfw_prd_asda_looker_01 /home/looker/looker/models-share
```