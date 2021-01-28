## cp


### NAME
cp -- copy files

### SYNOPSIS
> cp [-R [-H | -L | -P]] [-fi | -n] [-apvX] source_file target_file

> cp [-R [-H | -L | -P]] [-fi | -n] [-apvX] source_file ... target_directory

### DESCRIPTION
- In the first synopsis form, the cp utility copies the contents of the source_file to the target_file.  
- In the second synopsis form, the contents of each named source_file is copied to the destination target_directory.  The names of the files themselves are not changed. 


### OPTIONS
The following options are available:
* -R    
  * If source_file designates a directory, cp copies the directory and the entire subtree connected at that point.  
  * If the source_file ends in a /, the contents of the directory are copied rather than the directory itself. 
  * This option also causes symbolic links to be copied.  
  * Created directories have the same mode as the corresponding source directory, unmodified by the process' umask.
  * In -R mode, cp will continue copying even if errors are detected.
  * Note that cp copies hard-linked files as separate files.  If you need to preserve hard links, consider using tar(1), cpio(1), or pax(1) instead.
* -p
  * same as --preserve=mode,ownership,timestamps
* --preserve[=ATTR_LIST]
  * preserve the specified attributes (default: mode,ownership,timestamps), if possible additional attributes: context, links, xattr, all
* -f, --force
  * if an existing destination file cannot be opened, remove it and try again

### EXAMPLES

- Run the following command on the terminal

> cp -R {source-path} {destination-path}

```bash
cp -R /Users/asr000p/workspace/*.jar $pwd
```

