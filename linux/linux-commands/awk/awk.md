## awk

### NAME
awk - pattern-directed scanning and processing language

### SYNOPSIS
> awk [ -F fs ] [ -v var=value ] [ 'prog' | -f progfile ] [ file ...  ]


### EXAMPLES

- Print only columns one and three using stdin

```bash
$ awk ' {print $1,$3} '
this is one
this one
this is one two
this one
^C
$ 
```

- Print only elements from column 2 that match pattern using stdin 

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

- Classic "Hello, world" in awk 

```bash
$ awk "BEGIN { print \"Hello, world\" }"
Hello, world
$
```

4. Print what's entered on the command line until EOF

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

5. Extract first and last column of a text file

```bash
awk '{print $1, $NF}' filename
```