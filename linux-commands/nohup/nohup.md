## nohup

### NAME

nohup -- invoke a utility immune to hangups

Most of the time you login into remote server via ssh. If you start a shell script or command and you exit (abort remote connection), the process / command will get killed. Sometime job or command takes a long time. If you are not sure when the job will finish, then it is better to leave job running in background. But, if you log out of the system, the job will be stopped and terminated by your shell. What do you do to keep job running in the background when process gets SIGHUP? Say hello to nohup command

### SYNOPSIS

> nohup [--] utility [arguments]

### DESCRIPTION

The nohup utility invokes utility with its arguments and at this time sets the signal SIGHUP to be ignored.  If the standard output is a terminal, the standard output is appended to the file nohup.out in the current directory.  If standard error is a terminal, it is directed to the same place as the standard output.

Some shells may provide a builtin nohup command which is similar or identical to this utility.  Consult the builtin(1) manual page.

### ENVIRONMENT

The following variables are utilized by nohup:
* HOME  If the output file nohup.out cannot be created in the current directory, the nohup utility uses the directory named by HOME to create the file.
* PATH  Used to locate the requested utility if the name contains no `/' characters.

### EXIT STATUS

The nohup utility exits with one of the following values:
* 126     The utility was found, but could not be invoked.
* 127     The utility could not be found or an error occurred in nohup.
* Otherwise, the exit status of nohup will be that of utility.


### EXAMPLES

Syntax Wise

```bash
nohup command-name &
nohup /path/to/command-name arg1 arg2 &
```

Where
* command-name : is name of shell script or command name. You can pass argument to command or a shell script.
* & : nohup does not automatically put the command it runs in the background; you must do that explicitly, by ending the command line with an & symbol.

Running sqlplus in background in unix

```bash
$ nohup sqlplus USERNAME/password@DBNAME @test.sql &
$ nohup sqlplus USERNAME/password@SCHEMA_NAME @test.sql &
$ nohup sqlplus CAVERSION/password@ATGQA2 @/tmp/myscript.sql &
$ nohup sqlplus MTEPWSTAG/auwbkjdbfij8633@ASDADWH @/export/home/release/DB_Build/WMT_ASDA_DB/Slot_RPT/MTEPWSTAG/Scripts_BEFORE/R18_3_UKGRA-709_mtepwstag_183020.sql &
```