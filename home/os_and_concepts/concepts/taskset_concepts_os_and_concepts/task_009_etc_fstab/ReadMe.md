# /etc/fstab

<br>

## /etc/fstab file

[http://www.linfo.org/etc_fstab.html](http://www.linfo.org/etc_fstab.html)

fstab is a system configuration file on Linux and other Unix-like operating systems that contains information about major filesystems on the system. It takes its name from file systems table, and it is located in the /etc directory.

/etc/fstab can be safely viewed by using the cat command (which is used to read text files) as follows:

```bash
#
# /etc/fstab
# Created by anaconda on Mon Aug 14 20:57:26 2017
#
# Accessible filesystems, by reference, are maintained under '/dev/disk'
# See man pages fstab(5), findfs(8), mount(8) and/or blkid(8) for more info
#
UUID=784a2acb-e8a7-4485-a6f6-6c2333d013b1 /                       xfs defaults 0 0
/dev/vdb /mnt auto defaults,nofail,comment=cloudconfig 0 2
dfw-nfs3-vs10.prod.ankit.com:/stg_ankit_geo_01 /geo_camel_nfsshared/  nfs defaults 0 0
```
