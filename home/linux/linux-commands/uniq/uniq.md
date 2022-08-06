## uniq

### NAME

uniq -- report or filter out repeated lines in a file

### SYNOPSIS

> uniq [-c | -d | -u] [-i] [-f num] [-s chars] [input_file [output_file]]

### DESCRIPTION

The uniq utility reads the specified input_file comparing adjacent lines, and writes a copy of each unique input line to the output_file.  If input_file is a single dash (`-') or absent, the standard input is read. If output_file is absent, standard output is used for output. The second and succeeding copies of identical adjacent input lines are not written.  Repeated lines in the input will not be detected if they are not adjacent, so it may be necessary to sort the files first.

### OPTIONS

The following options are available:
*  -c      
  * Precede each output line with the count of the number of times the line occurred in the input, followed by a single space.
* -d
  * Only output lines that are repeated in the input.
* -f num  
  * Ignore the first num fields in each input line when doing comparisons.  A field is a string of non-blank characters separated from adjacent fields by blanks.  Field numbers are one based, i.e., the first field is field one.
* -s chars    
  * Ignore the first chars characters in each input line when doing comparisons.  If specified in conjunction with the -f option, the first chars characters after the first num fields will be ignored.  Character numbers are one based, i.e., the first character is character one.
* -u 
  * Only output lines that are not repeated in the input.
* -i 
  * Case insensitive comparison of lines.


```bash
$ cat testFile 
One Two
One Two
One Two Three Four
One Two Three Four
One Two Three Four
One
One 1
m-C02SN6PVG8WN:~ asr000p$ uniq testFile 
One Two
One Two Three Four
One
One 1
$ 
```