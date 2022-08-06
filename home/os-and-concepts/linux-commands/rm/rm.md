##rm

### NAME

rm, unlink -- remove directory entries

### SYNOPSIS

> rm [-dfiPRrvW] file …

> unlink file

### DESCRIPTION

The rm utility attempts to remove the non-directory type files specified on the command line.  If the permissions of the file do not permit writing, and the standard input device is a terminal, the user is prompted (on the standard error output) for confirmation.

### OPTIONS

The options are as follows:

* -d          
  * Attempt to remove directories as well as other types of files
* -f          
  * Attempt to remove the files without prompting for confirmation, regardless of the file's permissions.  If the file does not exist, do not display a diagnostic message or modify the exit status to reflect an error.  The -f option overrides any previous -i options.
* -R 
  * Attempt to remove the file hierarchy rooted in each file argument.  The -R option implies the -d option. If the -i option is specified, the user is prompted for confirmation before each directory's contents are processed (as well as before the attempt is made to remove the directory).  If the user does not respond affirmatively, the file hierarchy rooted in that directory is skipped.
* -r 
  * Equivalent to -R.
  
```bash
rm -rf directory_name
```
