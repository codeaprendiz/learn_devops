
GOPATH - Points to go workspace
GOROOT - Points to binary installation of go




- To compile go source code files

```bash
go build
```

- To compile and execute one or more go files

```bash
go run
```

- To format all code in current directory

```bash
go fmt
```

- To compile and install a package

```bash
go install
```

- Download the raw source code fo someone else's package

```bash
go get
```

- To run any test files associated with different projects

```bash
go test
```

- To get the go environment variables

```bash
$ go env        
GO111MODULE=""
GOARCH="amd64"
GOBIN=""
```

- To create a go module

```bash
go mod init
```

- To list all modules

```bash
$ go list -m all
example.com/hello
golang.org/x/text v0.0.0-20170915032832-14c0d48ead0c
rsc.io/quote v1.5.2
rsc.io/sampler v1.3.0
```

- To get all versions of given module

```bash
$ go list -m -versions rsc.io/sampler
rsc.io/sampler v1.0.0 v1.2.0 v1.2.1 v1.3.0 v1.3.1 v1.99.99
```

- To get specific version of module

```bash
$ go get rsc.io/sampler@v1.3.0       
```

- To remove all downloaded modules, you can pass the -modcache flag to go clean:


```bash
go clean -modcache
```


- You can use the go env command to portably set the default value for an environment variable for future go commands:

```bash
$ go env -w GOBIN=/somewhere/else/bin
```

- To unset a variable previously set by go env -w, use go env -u:

```bash
$ go env -u GOBIN
```
