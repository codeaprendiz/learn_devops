# grep

- [grep](https://man7.org/linux/man-pages/man1/grep.1.html)

## NAME

grep - print lines that match patterns

## EXAMPLES

- The following command is used to search for lines in the firewalld.conf file that start with "LogDenied"

```bash
$ grep '^LogDenied' /etc/firewalld/firewalld.conf
LogDenied=off
```
