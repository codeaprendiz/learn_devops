# export

- [export](#export)
  - [DESCRIPTION](#description)
  - [EXAMPLES](#examples)
    - [To export and add new executable in PATH](#to-export-and-add-new-executable-in-path)
    - [Exporting to child process](#exporting-to-child-process)

<br>

## DESCRIPTION

Shell builtin commands are commands that can be executed within the running shell's process.

The export command is one of the bash shell BUILTINS commands, which means it is part of your shell.

In general, the export command marks an environment variable to be exported with any newly forked child processes and thus it allows a child process to inherit all marked variables.

<br>

## EXAMPLES

<br>

### To export and add new executable in PATH

```bash
unzip /app/apache-maven-3.5.3.zip -d /app; chown -R app:app /app; export PATH=$PATH:/app/apache-maven-3.5.3/bin 
```

<br>

### Exporting to child process

```bash
# new variable called "a" is created to contain 2
$ a=2
$ echo $a
2
# we create a new child bash shell
$ bash
$ echo $a
# no output, variable "a" no longer have any values defined
```

Using export

```bash
# we have now used the export command to make the variable "a" to be exported when a new child process is created.
$ export a=2
$ bash
$ echo $a
2
```

