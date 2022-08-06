## cut


### NAME

cut - remove sections from each line of files

### SYNOPSIS

> cut [OPTION]... [FILE]...

### DESCRIPTION

Print selected parts of lines from each FILE to standard output. 

### OPTIONS

* -b, --bytes=LIST
    * select only these bytes
* -c, --characters=LIST
    * select only these character
* -d, --delimiter=DELIM
    * use DELIM instead of TAB for field delimiter
* -f, --fields=LIST
   * select only these fields;  
     also print any line that contains no delimiter character, unless the -s option is specified
* -n     
    * with -b: donât split multibyte characters
* --complement
    * complement the set of selected bytes, characters or fields.
* -s, --only-delimited
    * do not print lines not containing delimiters
* --output-delimiter=STRING
    * use STRING as the output delimiter the default is to use the input delimiter
* --help 
    * display this help and exit
* --version
    * output version information and exit

### EXAMPLES

```bash
$ df -kh .|cut -d'%' -f 1|awk '{print $NF}'|tail -1
```