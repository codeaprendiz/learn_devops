# which

<br>

## NAME

which -- locate a program file in the user's path

<br>

## SYNOPSIS

> which [-as] program ...

<br>

## DESCRIPTION

The which utility takes a list of command names and searches the path for each executable file that would be run had these commands actually been invoked.

Some shells may provide a builtin which command which is similar or identical to this utility.

<br>

## OPTIONS

* -a
  * List all instances of executables found (instead of just the first one of each).
* -s
  * No output, just return 0 if any of the executables are found, or 1 if none are found.

<br>

## EXAMPLES

which - shows the full path of (shell) commands

```bash
which java
```
