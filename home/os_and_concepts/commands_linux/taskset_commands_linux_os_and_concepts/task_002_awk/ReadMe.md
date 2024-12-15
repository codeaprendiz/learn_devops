# awk

[awk](https://man7.org/linux/man-pages/man1/awk.1p.html)

- [awk](#awk)
  - [NAME](#name)
  - [EXAMPLES](#examples)
    - [Print specific `columns`](#print-specific-columns)
    - [Using `pattern`](#using-pattern)
    - [`hello world`](#hello-world)
    - [Until `EOF`](#until-eof)
    - [`-F` | input field separators](#-f--input-field-separators)

<br>

## NAME

<br>

awk - pattern-directed scanning and processing language

<br>

## EXAMPLES

<br>

<br>

### Print specific `columns`

<br>

Print only columns one and three using stdin

```bash
$ awk ' {print $1,$3} '
this is one
this one
this is one two
this one
^C
$ 
```

Extract first and last column of a text file

```bash
awk '{print $1, $NF}' filename
```

<br>

### Using `pattern`

<br>

Print only elements from column 2 that match pattern using stdin

```bash
$ awk ' /'pattern'/ {print $2} '
this is first line
this is line containing pattern
is
patter at first
pattern at first
at
^C
$
```

<br>

### `hello world`

<br>

Classic "Hello, world" in awk

```bash
$ awk "BEGIN { print \"Hello, world\" }"
Hello, world
$
```

<br>

### Until `EOF`

<br>

Print what's entered on the command line until EOF

```bash
$ awk '{ print }'
this is
this is
new file
new file
end now^D
end now
^C
$
```

<br>

### `-F` | input field separators

<br>

To get unique URLs from a list.

```bash
cat <<EOF | awk -F/ '{print $3}' | sort | uniq
https://aws.amazon.com/ec2
https://example.org/page
http://example.org/login
https://sub.example.org/home
EOF
```

Output

```bash
aws.amazon.com
example.org
sub.example.org
```
