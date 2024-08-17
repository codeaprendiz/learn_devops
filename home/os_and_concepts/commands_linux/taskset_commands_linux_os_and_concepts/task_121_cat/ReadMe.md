# cat

- [cat](#cat)
  - [Examples](#examples)
    - [create a new file using cat and heredoc | EOF](#create-a-new-file-using-cat-and-heredoc--eof)
    - [Print the contents of a file](#print-the-contents-of-a-file)

## Examples

### create a new file using cat and heredoc | EOF

```bash
cat <<EOF > run.sh
#!/bin/bash

echo "File is run.sh"
EOF
```

### Print the contents of a file

```bash
cat run.sh
```
