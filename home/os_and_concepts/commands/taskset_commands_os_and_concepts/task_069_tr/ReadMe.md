# tr

[tr](https://man7.org/linux/man-pages/man1/tr.1.html)

<br>

## NAME

tr - translate or delete characters

<br>

## SYNOPSIS

> tr [OPTION]... SET1 [SET2]

<br>

## DESCRIPTION

Translate, squeeze, and/or delete characters from standard input,
writing to standard output.

<br>

## OPTIONS

- -d, --delete
  - delete characters

<br>

## EXAMPLES

- Delete all the newlines from john.csr file

```bash
cat john.csr | base64 | tr -d "\n"
.
```
