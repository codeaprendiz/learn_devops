# [set](https://man7.org/linux/man-pages/man1/set.1p.html)

- [set](#set)
  - [Examples](#examples)
    - [-x | Debugging](#-x--debugging)
    - [-e | Exit immediately || source](#-e--exit-immediately--source)
    - [set -o pipefail](#set--o-pipefail)
      - [Example Without `set -o pipefail`](#example-without-set--o-pipefail)
      - [Example With `set -o pipefail`](#example-with-set--o-pipefail)
      - [Combining with Other Options | -e | -u | -o pipefail](#combining-with-other-options---e---u---o-pipefail)

<br>

## Examples

<br>

### -x | Debugging

```bash
# Enable printing of each command to stdout before execution, for debugging
set -x
```

<br>

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

<br>

### set -o pipefail

By default, in a pipeline (a series of commands connected by `|`), the exit status of the pipeline is the exit status of the last command. This can mask errors in earlier commands in the pipeline.

When you enable `set -o pipefail`, the pipeline's return status is the exit status of the last command that had a non-zero exit status. If all commands in the pipeline succeed (return a zero exit status), the pipeline's exit status is zero.

<br>

#### Example Without `set -o pipefail`

```bash
$ bash without_pipefail.sh 
hello
This will still be printed
```

In this example, the `test` (non existent command) and `false` command fails, but because the exit status of the pipeline is determined `true` command the script does not exit immediately.

<br>

#### Example With `set -o pipefail`

```bash
bash with_pipefail.sh   
hello
```

In this example, with `set -o pipefail`, the script exits immediately because the `test` (non existent) and `false` command failed, even though the `true` command's exit status would be the last command in the pipeline.

<br>

#### Combining with Other Options | -e | -u | -o pipefail

[stackoverflow.com » What is the meaning of a question mark in bash variable parameter expansion as in ${var?}?](https://stackoverflow.com/questions/8889302/what-is-the-meaning-of-a-question-mark-in-bash-variable-parameter-expansion-as-i)

[www.gnu.org » Shell-Parameter-Expansion.html](https://www.gnu.org/software/bash/manual/html_node/Shell-Parameter-Expansion.html)

When used with `set -e` and `set -u`, `set -o pipefail` helps to create a robust script that:

- Exits on errors (`set -e`)
- Treats unset variables as errors (`set -u`)
- Properly handles pipeline errors (`set -o pipefail`)

Here’s how you might typically see them used together in a script:

```bash
$ bash using_set_eu_with_pipefail.sh 
using_set_eu_with_pipefail.sh: line 10: json_object: unbound variable
using_set_eu_with_pipefail.sh: line 10: SOMEVAR: Variable SOMEVAR is empty

$ echo $?
1

$ json_object='{"somekey": "example_value"}' bash using_set_eu_with_pipefail.sh
Variable SOMEVAR is assigned with: example_value
```
