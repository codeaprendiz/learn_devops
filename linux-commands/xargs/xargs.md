## xargs
 
### NAME

xargs -- construct argument list(s) and execute utility

### SYNOPSIS

> xargs [-0opt] [-E eofstr] [-I replstr [-R replacements]] [-J replstr] [-L number] [-n number [-x]] [-P maxprocs] [-s size] [utility [argument ...]]

### DESCRIPTION

The xargs utility reads space, tab, newline and end-of-file delimited strings from the standard input and executes utility with the strings as arguments.

Any arguments specified on the command line are given to utility upon each invocation, followed by some number of the arguments read from the standard input of xargs.  The utility is repeatedly executed until standard input is exhausted.

Spaces, tabs and newlines may be embedded in arguments using single (`` ' '') or double (``"'') quotes or backslashes (``\'').  Single quotes escape all non-single quote characters, excluding newlines, up to the matching single quote. Double quotes escape all non-double quote characters, excluding newlines, up to the matching double quote.  Any single character, including newlines, may be escaped by a backslash.

Some commands like grep can accept input as parameters, but some commands accepts arguments, this is place where xargs came into picture.

### EXAMPLES

```bash
$ echo "newDir" | mkdir      
usage: mkdir [-pv] [-m mode] directory ...
$ echo "newDir" | xargs mkdir                                                                                                                               
$ ls
newDir
```