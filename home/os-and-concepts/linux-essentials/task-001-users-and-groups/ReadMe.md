# Learn About Users And Groups In Linux

Let's use ubuntu

```bash
$ cat /etc/os-release
PRETTY_NAME="Ubuntu 22.04.1 LTS"
NAME="Ubuntu"
VERSION_ID="22.04"
VERSION="22.04.1 LTS (Jammy Jellyfish)"
```

## whoami

```bash
$ whoami
ubuntu
```

## Information about the user-id 

```bash
# cat /etc/passwd
$ cat /etc/passwd
root:x:0:0:root:/root:/bin/bash
daemon:x:1:1:daemon:/usr/sbin:/usr/sbin/nologin
bin:x:2:2:bin:/bin:/usr/sbin/nologin
..
ubuntu:x:1000:1000:Ubuntu:/home/ubuntu:/bin/bash
lxd:x:999:100::/var/snap/lxd/common/lxd:/bin/false
```

## Group information

```bash
$ cat /etc/group
root:x:0:
daemon:x:1:
.
.
ubuntu:x:1000:
#
```

## Get details about a particular user

```bash
$ id ubuntu
uid=1000(ubuntu) gid=1000(ubuntu) groups=1000(ubuntu),4(adm),20(dialout),24(cdrom),25(floppy),27(sudo),29(audio),30(dip),44(video),46(plugdev),118(netdev),119(lxd)
$ id root
uid=0(root) gid=0(root) groups=0(root)
```

## To get user home directory

```bash
$ grep -i ubuntu /etc/passwd
ubuntu:x:1000:1000:Ubuntu:/home/ubuntu:/bin/bash
```

## To check all users currently logged in

```bash
$ who
ubuntu   pts/0        2022-10-26 12:05 (5.194.32.235)
```

## To get record of all logged in users and the date and time of last reboot

```bash
$ last
ubuntu   pts/0        5.194.32.235     Wed Oct 26 12:05   still logged in
reboot   system boot  5.15.0-1019-aws  Wed Oct 26 11:59   still running

wtmp begins Wed Oct 26 11:59:53 2022
```

## Get the default configuration for sudo

> %admin ALL=(ALL) ALL

- Groups beging with `%` symbol
- First ALL signifies the host where the user can do priviledge excalation
- Second `(ALL)` indicates that all users can be used to run the command
- Third All indicates the command that can be run. All Indicates any command without restrictions.

```bash
$ sudo cat /etc/sudoers | grep -v "#"
Defaults	env_reset
Defaults	mail_badpass
Defaults	secure_path="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/snap/bin"
Defaults	use_pty
root	ALL=(ALL:ALL) ALL
%admin ALL=(ALL) ALL
%sudo	ALL=(ALL:ALL) ALL
@includedir /etc/sudoers.d
```


