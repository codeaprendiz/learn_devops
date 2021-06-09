## history

### NAME

To check the history

### SYNOPSIS

> history -c

> history -d offset

> history -anrw [filename]

> history -p arg [arg ...]

> history -s arg [arg …]

### DESCRIPTION

With no options, display the command history list with line numbers. 

Lines listed with a * have been modified. 

An argument of n lists only the last n lines.   

If the shell variable HISTTIMEFORMAT is set and not null, it is used as a format string for strftime(3) to display the timestamp associated with each displayed history entry. 

If  the HISTTIMEFORMAT variable is set, the time stamp information associated with each history entry is written to the history file, marked with the history comment character.  

When the history file is read, lines beginning with the history comment character followed immediately by a digit are interpreted as timestamps for the previous history line.   

The return value is 0 unless an invalid option is encountered, an error occurs while reading or writing the history file, an invalid offset is supplied as an argument to -d, or the history expansion supplied as an argument to -p fails. 

No intervening blank is printed between the formatted timestamp and the history line.  If filename is supplied, it is used as the name of the history file; if not, the value of HISTFILE is used.  Options, if supplied, have the following meanings:

### OPTIONS

* -c     
  * Clear the history list by deleting all the entries

* -d 
  * offset

* -n     
  * Read the history lines not already read from the history file into the current history list.  These are lines appended to the history file since the begin ning of the current bash session.


```bash
$echo 'export HISTTIMEFORMAT="%d/%m/%y %T "' >> ~/.bash_profile
$ source ~/.bash_profile
$ history 1
1032  03/03/19 01:06:00 history 1
```
