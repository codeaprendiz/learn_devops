## crontab

### NAME

crontab -- maintain crontab files for individual users (V3)

### SYNOPSIS

> crontab [-u user] file

> crontab [-u user] { -l | -r | -e }

**NOTE**

You should have a empty line at the end of crontab to work on Red Hat linux boxes.

### DESCRIPTION

The crontab utility is the program used to install, deinstall or list the tables used to drive the cron(8) daemon in Vixie Cron.  
Each user can have their own crontab, and they are not intended to be edited directly.

The syntax of writing crons is:

> 1 2 3 4 5 /path/to/command arg1 arg2

> 1 2 3 4 5 /root/backup.sh

```bash
Where,
1: Minute (0-59)      ex 0 signifies 0th minute, 1 signifies 1st minute
2: Hours (0-23)
3: Day (0-31)
4: Month (0-12 [12 == December])
5: Day of the week(0-7 [7 or 0 == sunday])
/path/to/command – Script or command name to schedule
```

### OPTIONS

- -e
     
    - This option is used to edit the current crontab using the editor specified by the VISUAL or EDITOR environment variables.  After you exit from the editor, the modified crontab will be installed automatically.

- -l 
    
    - The current crontab will be displayed on standard output.
    

#### EXAMPLES

To edit or create your own crontab file, type the following command at the UNIX / Linux shell prompt:

```bash
crontab -e
```

If you wished to have a script named /root/backup.sh run every day at 3am, your crontab entry would look like as follows. 
Append the following entry

```bash
0 3 * * * /root/backup.sh
```

Save and close the file.

To run /path/to/command five minutes after midnight, every day, enter

```bash
5 0 * * * /path/to/command
```

Run /root/scripts/perl/perlscript.pl at 23 minutes after midnight, 2am, 4am …, everyday, enter

```bash
23 0-23/2 * * * /root/scripts/perl/perlscript.pl
```

By default the output of a command or a script (if any produced), will be email to your local email account. To stop receiving email output from crontab you need to append >/dev/null 2>&1. For example

```bash
0 3 * * * /root/backup.sh >/dev/null 2>&1
```

To mail output to particular email account let us say vivek@nixcraft.inyou need to define MAILTO variable as follows

```bash
MAILTO="youremail@domain.com"
0 3 * * * /root/backup.sh >/dev/null 2>&1
```

To set up a cronjob for periodic deletion of log files which have not been modified since last 25 days.

```bash
12 12 * * * find /app/endeca/PlatformServices/workspace/logs -mtime +25 -exec rm -rf {} \; >>/app/clearLogs.log 2>&1
```

To list all your cron jobs

```bash
crontab -l
crontab -u username -l
```

To remove or erase all crontab jobs, use the following command

```bash
# delete the current cron job #
crontab -r
```

delete the job for specific user. Must be run as root user

```bash
crontab -r -u username
```