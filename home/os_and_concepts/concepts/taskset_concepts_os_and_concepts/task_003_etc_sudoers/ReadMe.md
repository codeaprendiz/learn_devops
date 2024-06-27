# /etc/sudoers

<br>

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
