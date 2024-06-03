# Essentials

- [Essentials](#essentials)
  - [output-redirection](#output-redirection)
  - [input-redirection](#input-redirection)
  - [dev-null-and-others-usually-used-in-redirection](#dev-null-and-others-usually-used-in-redirection)
    - [**\>/dev/null 2\>\&1 meaning**](#devnull-21-meaning)
    - [**\>, 1\>, 2\> meaning**](#-1-2-meaning)
    - [**3\>\&1 1\>\&2 2\>\&3 meaning**](#31-12-23-meaning)
    - [**Difference between \< and \<\< in shell command**](#difference-between--and--in-shell-command)
    - [**Difference between single and double quotes in Bash ( "" and '')**](#difference-between-single-and-double-quotes-in-bash---and-)

## output-redirection

The output from a command normally intended for standard output can be easily diverted to a file instead. This capability is known as output redirection.

If the notation > file is appended to any command that normally writes its output to standard output, the output of that command will be written to file instead of your terminal.

Check the following who command which redirects the complete output of the command in the users file.

```bash
$ who > users
$ cat users
oko         tty01 Sep 12 07:30
ai          tty15 Sep 12 13:32
ruth        tty21 Sep 12 10:10
pat         tty24 Sep 12 13:07
steve       tty25 Sep 12 13:03
$
```

If a command has its output redirected to a file and the file already contains some data, that data will be lost.

You can use >> operator to append the output in an existing file

## input-redirection

The commands that normally take their input from the standard input can have their input redirected from a file in this manner. For example, to count the number of lines in the file users generated above, you can execute the command as follows −

```bash
$ wc -l users
2 users
$
```

Upon execution, you will receive the following output. You can count the number of lines in the file by redirecting the standard input of the wc command from the file users −

```bash
$ wc -l < users
2
$
```

In the first case, wc knows that it is reading its input from the file users. In the second case, it only knows that it is reading its input from standard input so it does not display file name.

## dev-null-and-others-usually-used-in-redirection

### **>/dev/null 2>&1 meaning**

```bash
x * * * * /path/to/my/script > /dev/null 2>&1
```

- \> is for redirect
- /dev/null is a black hole where any data sent, will be discarded
- 2 is the file descriptor for Standard Error
- \> is for redirect
- & is the symbol for file descriptor (without it, the following 1 would be considered a filename)
- 1 is the file descriptor for Standard Out
- Therefore >/dev/null 2>&1 is redirect the output of your program to /dev/null. Include both the Standard Error and Standard Out.

### **>, 1>, 2> meaning**

The > operator redirects the output usually to a file but it can be to a device. You can also use >> to append.

If you don't specify a number then the standard output stream is assumed but you can also redirect errors

- \> file redirects stdout to file
- 1> file redirects stdout to file
- 2> file redirects stderr to file
- &> file redirects stdout and stderr to file

/dev/null is the null device it takes any input you want and throws it away. It can be used to suppress any output.

### **3>&1 1>&2 2>&3 meaning**

\>name means redirect output to file name.

\>&number means redirect output to file descriptor number.

The numbers are file descriptors and only the first three (starting with zero) have a standardized meaning:

- 0 - stdin
- 1 - stdout
- 2 - stderr

So each of these numbers in your command refer to a file descriptor. You can either redirect a file descriptor to a file with > or redirect it to another file descriptor with >&

The 3>&1 in your command line will create a new file descriptor and redirect it to 1 which is STDOUT. Now 1>&2 will redirect the file descriptor 1 to STDERR and 2>&3 will redirect file descriptor 2 to 3 which is STDOUT.

So basically you switched STDOUT and STDERR, these are the steps:

- Create a new fd 3 and point it to the fd 1
- Redirect file descriptor 1 to file descriptor 2. If we wouldn't have saved the file descriptor in 3 we would lose the target.
- Redirect file descriptor 2 to file descriptor 3. Now file descriptors one and two are switched.

Now if the program prints something to the file descriptor 1, it will be printed to the file descriptor 2 and vice versa.

### **Difference between < and << in shell command**

\> is used to write to a file and >> is used to append to a file.

Thus, when you use ps aux > file, the output of ps aux will be written to file and if a file named file was already present, its contents will be overwritten.

And if you use ps aux >> file, the output of ps aux will be written to file and if the file named file was already present, the file will now contain its previous contents and also the contents of ps aux, written after its older contents of file.

### **Difference between single and double quotes in Bash ( "" and '')**

Single quotes won't interpolate anything, but double quotes will. For example: variables, backticks, certain \ escapes, etc

The Bash manual has this to say:

SINGLE QUOTES

- Enclosing characters in single quotes (') preserves the literal value of each character within the quotes. A single quote may not occur between single quotes, even when preceded by a backslash.

DOUBLE QUOTES

- Enclosing characters in double quotes (") preserves the literal value of all characters within the quotes, with the exception of $, `, \, and, when history expansion is enabled, !. The characters $ and ` retain their special meaning within double quotes (see Shell Expansions). The backslash retains its special meaning only when followed by one of the following characters: $, `, ", \, or newline. Within double quotes, backslashes that are followed by one of these characters are removed. Backslashes preceding characters without a special meaning are left unmodified. A double quote may be quoted within double quotes by preceding it with a backslash. If enabled, history expansion will be performed unless an ! appearing in double quotes is escaped using a backslash. The backslash preceding the ! is not removed. The special parameters * and @ have special meaning when in double quotes
