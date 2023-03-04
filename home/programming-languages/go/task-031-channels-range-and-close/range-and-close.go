package main

/*
This is a Go code that generates a sequence of Fibonacci numbers using goroutines and channels.

The package main statement at the beginning indicates that this is the main package of a Go program.

The import ("fmt") statement imports the "fmt" package, which provides functions for formatting and printing text to the console.

The fibonacci function takes two parameters, n and c, where n is the number of Fibonacci numbers to generate, and c is a channel to which the Fibonacci numbers are sent.

Inside the fibonacci function, the variables x and y are initialized to 0 and 1, respectively. A for loop is used to generate n Fibonacci numbers. In each iteration, the value of x is sent to the channel c using the c <- x statement. Then, the values of x and y are updated to generate the next Fibonacci number using the expression x, y = y, x+y.
*/

import (
	"fmt"
)

func fibonacci(n int, c chan int) {
	x, y := 0, 1
	for i := 0; i < n; i++ {
		c <- x
		x, y = y, x+y
	}
	close(c)
}

func main() {
	c := make(chan int, 10)
	go fibonacci(cap(c), c)
	for i := range c {
		fmt.Println(i)
	}
}
