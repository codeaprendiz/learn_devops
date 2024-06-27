# Special Variables in Shell Scripts

<br>

## Special Variables

The following table shows a number of special variables that you can use in your shell scripts:

| Variable | Description                                                                                                                                                                                                                                 |
|----------|---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| `$0`     | The filename of the current script                                                                                                                                                                                                          |
| `$n`     | These variables correspond to the arguments with which a script was invoked. Here n is a positive decimal number corresponding to the position of an argument (the first argument is $1, the second argument is $2, and so on).             |
| `$#`     | The number of arguments supplied to a script                                                                                                                                                                                                |
| `$*`     | All the arguments are double quoted. If a script receives two arguments, `$*` is equivalent to `$1 $2`                                                                                                                                      |
| `$@`     | All the arguments are individually double quoted. If a script receives two arguments, `$@` is equivalent to `$1 $2`                                                                                                                         |
| `$?`     | The exit status of the last command executed. Exit status is a numerical value returned by every command upon its completion. As a rule, most commands return an exit status of 0 if they were successful, and 1 if they were unsuccessful. |
| `$$`     | The process number of the current shell. For shell scripts, this is the process ID under which they are executing.                                                                                                                          |
| `$!`     | The process ID of the last background command executed.                                                                                                                                                                                     |
| `$1`     | The first argument to the shell script                                                                                                                                                                                                      |
| `$2`     | The second argument to the shell script                                                                                                                                                                                                     |

<br>

### Command line Arguments

The command-line arguments $1, $2, $3, ...$9 are positional parameters, with $0 pointing to the actual command, program, shell script, or function and $1, $2, $3, ...$9 as the arguments to the command.

Following script uses various special variables related to the command line −

```bash
#!/bin/sh
echo "File Name: $0"
echo "First Parameter : $1"
echo "Second Parameter : $2"
echo "Quoted Values: $@"
echo "Quoted Values: $*"
echo "Total Number of Parameters : $#"
```

Here is the output of the following script

```bash
$./test.sh Zara Ali
File Name : ./test.sh
First Parameter : Zara
Second Parameter : Ali
Quoted Values: Zara Ali
Quoted Values: Zara Ali
Total Number of Parameters : 2
```
