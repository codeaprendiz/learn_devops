# tty

<br>

## NAME

tty - print the file name of the terminal connected to standard input

<br>

### SYNOPSIS

> tty [OPTION]...

<br>

## DESCRIPTION

Print the file name of the terminal connected to standard input.

<br>

## OPTIONS

* -s, --silent, --quiet

  * print nothing, only return an exit status

* --help display this help and exit

* --version
  * output version information and exit

```bash
[admin@hostname ~]$ tty
/dev/pts/0
```

```bash
[ngcs_tg@dolnxprdxnvm33 ~]$ tty
/dev/pts/0
```
