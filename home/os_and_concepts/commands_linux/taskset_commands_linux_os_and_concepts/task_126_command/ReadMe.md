# command

[stackoverflow.com](https://askubuntu.com/questions/512770/what-is-the-bash-command-command) command is useful, for example, if you want to check for the existence of a particular command. which includes aliases into the lookup so it is not suitable for this purpose because you don't want a random alias to be considered as the command in question.

## Examples

Check if a command exists

```bash
command -v ls
```

```bash
command -v trivy
```
