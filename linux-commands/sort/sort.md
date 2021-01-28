##sort

### NAME

sort - sort lines of text file

### SYNOPSIS

sort [OPTION]... [FILE]...

### DESCRIPTION

Write sorted concatenation of all FILE(s) to standard output.

### OPTIONS

* -b, --ignore-leading-blanks
  * ignore leading blanks
* -d, --dictionary-order
  * consider only blanks and alphanumeric characters
* -f, --ignore-case
  * fold lower case to upper case characters
* -g, --general-numeric-sort
  * compare according to general numerical value
* -i, --ignore-nonprinting
  * consider only printable characters
* -M, --month-sort
  * compare (unknown) < `JAN' < ... < `DEC'
* -n, --numeric-sort
  * compare according to string numerical value
* -r, --reverse
  * reverse the result of comparisons
  
### EXAMPLES

```bash
$ cat num alpha alphaNum
2
1
b
a
z 1
y 2
$ sort num alpha alphaNum
1
2
a
b
y 2 
z 1
$
```