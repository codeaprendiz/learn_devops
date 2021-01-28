## tail

### NAME

tail -- display the last part of a file

### SYNOPSIS

> tail [-F | -f | -r] [-q] [-b number | -c number | -n number] [file ...]

### DESCRIPTION

The tail utility displays the contents of file or, by default, its standard input, to the standard output.

The display begins at a byte, line or 512-byte block location in the input.  Numbers having a leading plus (`+') sign are relative to the beginning of the input, for example, ``-c +2'' starts the display at the second byte of the input.  Numbers having a leading minus (`-') sign or no explicit sign are relative to the end of the input, for example, ``-n 2'' displays the last two lines of the input.  The default starting location is ``-n 10'', or the last 10 lines of the input.

### OPTIONS

* -f     
  * The -f option causes tail to not stop when end of file is reached, but rather to wait for additional data to be appended to the input.  The -f option is ignored if the standard input is a pipe, but not if it is a FIFO. 
  * Now to start with the last 100 lines of server.log we use the following command.
  
```bash
tail -100f server.log
```