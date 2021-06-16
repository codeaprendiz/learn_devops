[Doc](https://medium.com/rungo/everything-you-need-to-know-about-packages-in-go-b8bac62b74cc)

[Go-Doc](https://golang.org/doc/code)

A package name is the name of the directory contained in src directory. In the above case, app is the package since app is the child directory of src directory. Hence, go install app command looked for app sub-directory inside src directory of GOPATH (since GOROOT doesn’t have it).

```bash
$ echo $GOBIN                                                       


$ echo $GOPATH
/Users/ankitsinghrathi/Ankit/workspace/devops-essentials/languages/go/task-057-creating-packages/goworkspace

$ pwd        
/Users/ankitsinghrathi/Ankit/workspace/devops-essentials/languages/go/task-057-creating-packages/goworkspace/src/app

$ go mod init github.com/codeaprendiz/app
go: creating new go.mod: module github.com/codeaprendiz/app
go: to add module requirements and sums:
        go mod tidy

$ cat go.mod                          
module github.com/codeaprendiz/app

go 1.16

$ go install github.com/codeaprendiz/app

## this creates binary in bin directory
$ tree -L 2 ../../    
../../
├── bin
│   └── app
├── pkg
│   └── mod
└── src
    └── app
```


The install directory is controlled by the GOPATH and GOBIN environment variables. If GOBIN is set, binaries are installed to that directory. If GOPATH is set, binaries are installed to the bin subdirectory of the first directory in the GOPATH list. Otherwise, binaries are installed to the bin subdirectory of the default GOPATH ($HOME/go or %USERPROFILE%\go).

Lets create one more package and then try importing it

If a package does not contain a file with main package declaration, then Go creates a package archive (.a) file inside pkg directory.

```bash
$ mkdir reversestring
$ go mod init github.com/codeaprendiz/morestrings  
$ go install github.com/codeaprendiz/morestrings  
$ tree -L 3 ../../
../../
├── bin
│   └── app
├── pkg
│   ├── darwin_amd64
│   │   └── reversestring.a
│   └── mod
│       └── cache
└── src
    ├── app
    │   ├── ReadMe.md
    │   ├── app.go
    │   └── go.mod
    └── reversestring
        ├── go.mod
        └── reverse.go
```


