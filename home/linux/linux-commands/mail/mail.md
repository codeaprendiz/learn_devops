## mail

### NAME

- mail - send and receive mail

### SYNOPSIS

> mail [-iInv] [-s subject] [-c cc-addr] [-b bcc-addr] to-addr... [-- sendmail-options...]

> mail [-iInNv] -f [name]

> mail [-iInNv] [-u user]

### Description

Mail is an intelligent mail processing system, which has a command syntax reminiscent of ed(1) with lines replaced by messages.

### OPTIONS

* -v   
  * Verbose mode.  The details of delivery are displayed on the user on terminal.
* -i   
  * Ignore tty interrupt signals.  This is particularly useful when using mail on noisy phone lines.
* -I    
  * Forces mail to run in interactive mode even when input isnât a terminal.  In particular, the â~â special character when sending mail is only active in interactive mode
* -n    
  * Inhibits reading /etc/mail.rc upon startup.
* -N    
  * Inhibits the initial display of message headers when reading mail or editing a mail folder.
* -s    
  * Specify subject on command line (only the first argument after the -s flag is used as a subject; be careful to quote subjects containing spaces.)
* -c
  * Send carbon copies to list of users.
-b 
  * Send blind carbon copies to list.  List should be a comma-separated list of names.

### EXAMPLE

```bash
-bash-3.2$ echo "Mail Body" | mail -v -s "Subject" "ankit.rathi@accelya.com"

$ mail -s "$WRKSPZ_BRNC_IN Build Stopped at `date` [Machine:`hostname`]: Build-Locks found" "${SCM_MAIL_G}"<${BLD_LOCK}
```

