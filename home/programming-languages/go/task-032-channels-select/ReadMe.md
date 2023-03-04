# Select

[https://go.dev/tour/concurrency/5](https://go.dev/tour/concurrency/5)

## Explaination

```bash
This is a Go code that generates a sequence of Fibonacci numbers using goroutines and channels, and terminates the generation when a quit signal is received through a separate channel.

The package main statement at the beginning indicates that this is the main package of a Go program.

The import "fmt" statement imports the "fmt" package, which provides functions for formatting and printing text to the console.

The fibonacci function takes two channels as parameters, c and quit. The c channel is used to send the generated Fibonacci numbers, and the quit channel is used to signal the end of the generation.

Inside the fibonacci function, the variables x and y are initialized to 0 and 1, respectively. A for loop with a select statement is used to generate an infinite number of Fibonacci numbers until a quit signal is received through the quit channel.
```

```bash
$ go run select.go         
0
1
1
2
3
Quit
```