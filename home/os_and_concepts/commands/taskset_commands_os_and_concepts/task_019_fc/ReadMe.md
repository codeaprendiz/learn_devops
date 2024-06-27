# fc

[fc](https://www.unix.com/man-page/linux/1/fc)

The fc utility shall list, or shall edit and re-execute, commands previously entered to an interactive sh.

<br>

## Examples

- Sometimes it's useful to copy the last used command to clipboard

```bash
$ echo "hello"
hello
$ fc -ln -1 | pbcopy
.
# CMD + V in terminal 
$ echo "hello"
.
```
