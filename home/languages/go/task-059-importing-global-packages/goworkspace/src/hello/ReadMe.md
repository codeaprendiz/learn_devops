[How to Write Go Code](https://golang.org/doc/code)


- Create directory `hello` inside `src`

```bash
$ mkdir hello   
$ cd hello
```

- Initialize

```bash
$ go mod init github.com/codeaprendiz/hello
go: creating new go.mod: module github.com/codeaprendiz/hello

$ cat go.mod
module github.com/codeaprendiz/hello

go 1.16
```

- Now create `hello.go` 

```bash
$ touch hello.go
$ cat hello.go
package main

import "fmt"
import "github.com/codeaprendiz/hello/morestrings"

func main() {
	fmt.Println("Hello, world.")
	fmt.Println(morestrings.ReverseRunes("dlrow, olleh"))
}
```

- Install to create binary

```bash
$ go install github.com/codeaprendiz/hello 

### Execute and check
$ ../../bin/hello
Hello, world.
```

- Now create `morestrings` inside `src`

```bash
$ cd morestrings 
$ touch reverse.go

$ cat reverse.go
// Package morestrings implements additional functions to manipulate UTF-8
// encoded strings, beyond what is provided in the standard "strings" package.
package morestrings

// ReverseRunes returns its argument string reversed rune-wise left to right.
func ReverseRunes(s string) string {
	r := []rune(s)
	for i, j := 0, len(r)-1; i < len(r)/2; i, j = i+1, j-1 {
		r[i], r[j] = r[j], r[i]
	}
	return string(r)
}


$ go build
```

- Now again install hello

```bash
$ go install github.com/codeaprendiz/hello
```

- Execute the binary finally

```bash
$ ../../bin/hello
Hello, world.
hello ,world
```

- Now let's try to add external dependency. Add the following import

> 	"github.com/google/go-cmp/cmp"

```bash
$ go get -u github.com/google/go-cmp/cmp   
$ ls ../../pkg/mod/github.com/                        
google             
```

- Check the `go.mod`

```bash
$ cat go.mod
module github.com/codeaprendiz/hello

go 1.16

require github.com/google/go-cmp v0.5.6
```


- Install and run the binary

```bash
$ ../../bin/hello
Hello, world.
hello ,world
  string(
-       "Hello World",
+       "Hello Go",
  )

```