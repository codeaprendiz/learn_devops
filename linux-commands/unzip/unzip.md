## unzip 

### NAME

unzip - list, test and extract compressed files in a ZIP archive

### SYNOPSIS

> unzip [-Z] [-cflptTuvz[abjnoqsCDKLMUVWX$/:^]] file[.zip] [file(s) ...]  [-x xfile(s) ...] [-d exdir]

### DESCRIPTION

unzip  will list, test, or extract files from a ZIP archive, commonly found on MS-DOS systems.  The default behavior (with no options) is to extract into the current directory (and subdirectories below it) all files from the specified ZIP archive.

### OPTIONS

* [-d exdir]
  * An  optional directory to which to extract files.  By default, all files and subdirectories are recreated in the current directory; the -d option allows extraction in an arbitrary directory (always assuming one has permission to write to the directory).

### EXAMPLES

To unzip to a particular directory

```bash
$ unzip /tmp/phantomjs.zip -d /tmp;
```

To use unzip to extract all members of the archive letters.zip into the current directory and subdirectories below it, creating any subdirectories as necessary:

```bash
$ unzip letters
```

 To extract all members of letters.zip into the current directory only:

```bash
unzip -j letters
```

Here -j option signifies junk paths. The archive's directory structure is not recreated; all files are deposited in the extraction directory (by default, the current one).
