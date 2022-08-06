## zip 


### NAME

zip - package and compress (archive) files

### SYNOPSIS

> zip [-aABcdDeEfFghjklLmoqrRSTuvVwXyz!@$] [--longoption ...]  [-b path] [-n suffixes] [-t date] [-tt date] [zipfile [file ...]]  [-xi list]

### DESCRIPTION

zip is a compression and file packaging utility for Unix, VMS, MSDOS, OS/2, Windows 9x/NT/XP, Minix, Atari, Macintosh, Amiga, and Acorn RISC OS.  It is analogous to a combination of the Unix commands tar(1) and compress(1) and is compatible with PKZIP (Phil Katz's ZIP for MSDOS systems).

### EXAMPLES

Command format.  The basic command format is

> zip options archive inpath inpath ...
 
* where  archive is a new or existing zip archive and inpath is a directory or file path optionally including wildcards.  When given the name of an existing zip archive, zip will replace identically named entries in the zip archive (matching the relative names as stored in the archive) or add entries for new names.  For example, if foo.zip exists and contains foo/file1 and foo/file2, and the directory foo contains the files foo/file1 and foo/file3, then:

```bash
zip -r foo.zip foo
or 
 zip -r foo foo
```

- will replace foo/file1 in foo.zip and add foo/file3 to foo.zip.  After this, foo.zip contains foo/file1, foo/file2, and foo/file3, with foo/file2 unchanged from before.

- Here -r is for recurse paths
 
- In this case, all the files and directories in foo are saved in a zip archive named foo.zip, including files with names starting with ".", since the recursion  does not use the shell's file-name substitution mechanism.

- To add a jar to an existing war you can use the following command

```bash
zip -d xx-xx-xx.war WEB-INF/lib/xx-xx-xx-5.4.2.0.jar
```