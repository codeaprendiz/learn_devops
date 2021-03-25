### Blocking code example

The program blocks execution until File is read completely.

```bash
$ node blocking-code.js
This is text File.
Program Ended
```

### Non Blocking code example

The program does not wait to the file to be read completely and continues with the
operation. This makes nodejs higly scalable as it makes use of heavy call backs.

```bash
$ node non-blocking-code.js 
Program Ended
This is text File.
```

