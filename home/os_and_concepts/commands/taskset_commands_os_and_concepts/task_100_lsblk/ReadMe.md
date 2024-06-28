# lsblk

- [lsblk](https://man7.org/linux/man-pages/man8/lsblk.8.html)

## NAME

lsblk - list block devices

## EXAMPLES

To get the disknames and mountpoints

```bash
root@ip-172-23-45-36:/# lsblk
NAME        MAJ:MIN RM  SIZE RO TYPE MOUNTPOINT
nvme0n1     259:0    0   20G  0 disk
└─nvme0n1p1 259:1    0    8G  0 part /
```
