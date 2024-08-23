
# eof-here-doc

## eof-here-document

A here document is used to redirect input into an interactive shell script or program.

We can run an interactive program within a shell script without user action by supplying the required input for the interactive program, or interactive shell script.

The general form for a here document is −

```bash
command << delimiter
document
delimiter
```

Here the shell interprets the << operator as an instruction to read input until it finds a line containing the specified delimiter. All the input lines up to the line containing the delimiter are then fed into the standard input of the command.

The delimiter tells the shell that the here document has completed. Without it, the shell continues to read the input forever. The delimiter must be a single word that does not contain spaces or tabs.

Following is the input to the command wc -l to count the total number of lines −

```bash
$wc -l << EOF
   This is a simple lookup program 
for good (and bad) restaurants
in Cape Town.
EOF
3
$
```

## multi-line-here-document

[Multiline syntax for piping a heredoc](https://stackoverflow.com/questions/7046381/multiline-syntax-for-piping-a-heredoc-is-this-portable)

```bash
cat << EOF | grep "apple"
banana
apple
orange
EOF
```

Output

```bash
apple
```
