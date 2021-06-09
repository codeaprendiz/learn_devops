## ln

### NAME

link, ln -- make links

### SYNOPSIS

> ln [-Ffhinsv] source_file [target_file]

> ln [-Ffhinsv] source_file ... target_dir

> link source_file target_file

### DESCRIPTION

The ln utility creates a new directory entry (linked file) which has the same modes as the original file.  It is useful for maintaining multiple copies of a file in many places at once without using up storage for the ``copies''; instead, a link ``points'' to the original copy.  There are two types of links; hard links and symbolic links. How a link ``points'' to a file is one of the differences between a hard and symbolic link.

If you want to create a new symbolic link then you can use the following command. If you want to change the existing symbolic link then you can delete the existing symbolic link using rm command and then create a new one.

You can check where a symbolic link points to using the ls -l fileName command

ln -s Existing-file New-name

### OPTIONS

* -s
    * Create a symbolic link.

### EXAMPLE

```bash
$ rm java
$ ln -s /usr/lib/jvm/java-8-oracle/jre/bin/java java
```
