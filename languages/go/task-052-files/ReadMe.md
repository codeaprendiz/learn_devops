- Run the following 

```bash
$ go run main.go
open names.txt: no such file or directory

$ echo "Hello world" > names.txt; go run main.go; rm -rf names.txt;
The file content is  Hello world

```