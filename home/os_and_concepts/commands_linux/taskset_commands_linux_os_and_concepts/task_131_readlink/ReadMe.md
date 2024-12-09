# readlink

<br>

## Examples

<br>

To find the absolute paths all folders that start with `task_*`

```bash
find . -name "task_*" -type d | xargs -I % readlink -f %
```
