## tar

### NAME

tar -- manipulate tape archives

### SYNOPSIS

> tar [bundled-flags <args>] [<file> | <pattern> ...]

> tar {-c} [options] [files | directories]

> tar {-r | -u} -f archive-file [options] [files | directories]

> tar {-t | -x} [options] [patterns]

### DESCRIPTION

tar creates and manipulates streaming archive files.  This implementation can extract from tar, pax, cpio, zip, jar, ar, and ISO 9660 cdrom images and can create tar, pax, cpio, ar, and shar archives.
 
The first synopsis form shows a ``bundled'' option word.  This usage is provided for compatibility with historical implementations.

The other synopsis forms show the preferred usage.  The first option to tar is a mode indicator from the following list:

* -c      
  * Create a new archive containing the specified items.
* -r      
  * Like -c, but new entries are appended to the archive.  Note that this only works on uncompressed archives stored in regular files.  The -f option is required.
* -t      
  * List archive contents to stdout.
* -u     
  * Like -r, but new entries are added only if they have a modification date newer than the corresponding entry in the archive.  Note that this only works on uncompressed archives stored in regular files. The -f option is required.
* -x      
  * Extract to disk from the archive.  If a file with the same name appears more than once in the archive, each copy will be extracted, with later copies overwriting (replacing) earlier copies.

In -c, -r, or -u mode, each specified file or directory is added to the archive in the order specified on the command line.  By default, the contents of each directory are also archived.

In extract or list mode, the entire command line is read and parsed before the archive is opened.  The pathnames or patterns on the command line indicate which items in the archive should be processed.

### OPTIONS

* -v      
  * Produce verbose output.  In create and extract modes, tar will list each file name as it is read from or written to the archive.  In list mode, tar will produce output similar to that of ls(1). Additional -v options will provide additional detail.
* -f file
  * Read the archive from or write the archive to the specified file.  The filename can be - for standard input or standard output.
* -x      
  * Extract to disk from the archive.  If a file with the same name appears more than once in the archive, each copy will be extracted, with later copies overwriting (replacing) earlier copies.

### EXAMPLES

Consider the following example

```bash
$ tar -cvf file.tar file1 file2 file3
```