- Run the following command

```bash
$ go test                      
hello.go:3:8: no required module provides package rsc.io/quote; to add it:
        go get rsc.io/quote
```

- Install the modules

```bash
$ go get 
go: downloading rsc.io/quote v1.5.2
go: downloading rsc.io/sampler v1.3.0
go: downloading golang.org/x/text v0.0.0-20170915032832-14c0d48ead0c
go get: added rsc.io/quote v1.5.2

$ cat go.mod                   
module example.com/hello

go 1.16

require rsc.io/quote v1.5.2
```