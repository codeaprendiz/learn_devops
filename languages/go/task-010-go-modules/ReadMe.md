- Run the following command

```bash
$ ls
ReadMe.md     hello.go      hello_test.go

$ go test   
go: cannot find main module, but found .git/config in /Users/ankitsinghrathi/Ankit/workspace/devops-essentials
        to create a module there, run:
        cd ../.. && go mod init


$ go mod init example.com/hello
go: creating new go.mod: module example.com/hello
go: to add module requirements and sums:
        go mod tidy

$ ls
ReadMe.md     go.mod        hello.go      hello_test.go

$ go test
PASS
ok      example.com/hello       0.397s        
```