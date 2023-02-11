# Calling external package

[https://go.dev/doc/tutorial/getting-started](https://go.dev/doc/tutorial/getting-started)


Visit pkg.go.dev and search for a [quote](https://pkg.go.dev/rsc.io/quote/v4) package.

```bash
$ touch hello-world.go

$ go mod init example/hello                              
go: creating new go.mod: module example/hello
go: to add module requirements and sums:
        go mod tidy

$ go run .                 
hello-world.go:5:8: no required module provides package rsc.io/quote; to add it:
        go get rsc.io/quote

$ go mod tidy              
go: finding module for package rsc.io/quote
go: downloading rsc.io/quote v1.5.2
go: found rsc.io/quote in rsc.io/quote v1.5.2
go: downloading rsc.io/sampler v1.3.0
go: downloading golang.org/x/text v0.0.0-20170915032832-14c0d48ead0c


go run .   
Don't communicate by sharing memory, share memory by communicating.
```