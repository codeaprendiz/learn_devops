# grep

- [grep](#grep)
  - [NAME](#name)
  - [EXAMPLES](#examples)
    - [To search for a pattern in a file](#to-search-for-a-pattern-in-a-file)
    - [To get user home directory | -i](#to-get-user-home-directory---i)

<br>

## NAME

grep - print lines that match patterns

<br>

## EXAMPLES

<br>

### To search for a pattern in a file

- The following command is used to search for lines in the firewalld.conf file that start with "LogDenied"

```bash
grep '^LogDenied' /etc/firewalld/firewalld.conf
```

Output

```bash
LogDenied=off
```

<br>

### To get user home directory | -i

```bash
grep -i ubuntu /etc/passwd
```

Output

```bash
ubuntu:x:1000:1000:Ubuntu:/home/ubuntu:/bin/bash
```
