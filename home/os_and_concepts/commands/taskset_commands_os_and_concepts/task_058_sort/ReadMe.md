# sort

## NAME

sort - sort lines of text file

## DESCRIPTION

Write sorted concatenation of all FILE(s) to standard output.

## OPTIONS

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
  * compare (unknown) < `JAN' < ... < DEC`
* -n, --numeric-sort
  * compare according to string numerical value
* -r, --reverse
  * reverse the result of comparisons
* -V --version-sort
  * natural sort of (version) numbers within text
  
## EXAMPLES

```bash
$ ls sort* | sort -V
sort-1.022.tgz
sort-1.23.tgz
```
