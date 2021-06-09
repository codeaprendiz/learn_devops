## sudo

### NAME

sudo, sudoedit - execute a command as another user

### SYNOPSIS

> sudo -h | -K | -k | -V

> sudo -v [-AknS] [-g group] [-h host] [-p prompt] [-u user]

> sudo -l [-AknS] [-g group] [-h host] [-p prompt] [-U user] [-u user] [command]

> sudo [-AbEHnPS] [-C num] [-g group] [-h host] [-p prompt] [-u user] [VAR=value] [-i | -s] [command]

> sudoedit [-AknS] [-C num] [-g group] [-h host] [-p prompt] [-u user] file ...

### DESCRIPTION

sudo allows a permitted user to execute a command as the superuser or another user, as specified by the security policy.  The invoking user's real (not effective) user ID is used to determine the user name with which to query the security policy.

### EXAMPLE

To switch to a user “looker”

```bash
sudo su - looker
```

To execute a shell script using a particular user

```bash
sudo su - looker -c "sh /home/looker/looker/start.sh
```

Content of start.sh

```bash
sh /home/looker/looker/looker start;
```