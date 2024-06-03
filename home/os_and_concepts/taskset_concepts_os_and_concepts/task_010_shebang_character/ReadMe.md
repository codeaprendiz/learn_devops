# Shebang character

## #! /Shebang character

In computing, a shebang is the character sequence consisting of the characters number sign and exclamation mark (#!) at the beginning of a script.

In Unix-like operating systems, when a text file with a shebang is used as if it is an executable, the program loader parses the rest of the file's initial line as an interpreter directive; the specified interpreter program is executed, passing to it as an argument the path that was initially used when attempting to run the script,[8] so that the program may use the file as input data. For example, if a script is named with the path path/to/script, and it starts with the following line, #!/bin/sh, then the program loader is instructed to run the program /bin/sh, passing path/to/script as the first argument

SYNTAX

The form of a shebang interpreter directive is as follows:

> \#!interpreter [optional-arg]

- in which interpreter is an absolute path to an executable program. The optional argument is a string representing a single argument. White space after #! is optional. In Linux, the file specified by interpreter can be executed if it has the execute right and contains code which the kernel can execute directly, if it has a wrapper defined for it via sysctl (such as for executing Microsoft EXE binaries using wine), or if it contains a shebang.
- Some other example shebangs are:

```bash
#!/bin/sh — Execute the file using sh, the Bourne shell, or a compatible shell 
#!/bin/csh — Execute the file using csh, the C shell, or a compatible shell 
#!/usr/bin/perl -T — Execute using Perl with the option for taint checks 
#!/usr/bin/php — Execute the file using the PHP command line interpreter 
#!/usr/bin/python -O — Execute using Python with optimizations to code 
#!/usr/bin/ruby — Execute using Ruby 
```