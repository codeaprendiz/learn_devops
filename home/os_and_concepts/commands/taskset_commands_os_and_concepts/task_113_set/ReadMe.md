# [set](https://man7.org/linux/man-pages/man1/set.1p.html)

## Examples

### -x | Debugging

```bash
# Enable printing of each command to stdout before execution, for debugging
set -x
```

### -e | Exit immediately || source

```bash
# Make bash script exit immediately if any command returns a non-zero exit status
set -e
```

With multiple scripts

```bash
# Note: caller_script.sh calls called_script.sh. The called script fails with a non-zero exit status. The caller script has set -e, so it exits immediately after the called script fails.
$ bash caller_script.sh     
Caller script: before calling the called script
Called script: inside the called script. Before failing
```
