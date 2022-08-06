package main

import (
	"fmt"
	"runtime"
	"sync"
)

var wg sync.WaitGroup

func main() {
	fmt.Println("OS ", runtime.GOOS)
	fmt.Println("Arch ", runtime.GOARCH)
	fmt.Println("CPUs ", runtime.NumCPU())
	fmt.Println("Go routines  ", runtime.NumGoroutine())

	wg.Add(1)

	go foo()

	bar()

	fmt.Println("CPUs ", runtime.NumCPU())
	fmt.Println("Go routines  ", runtime.NumGoroutine())

	wg.Wait()
}

func foo() {
	for i:=0; i<10; i++ {
		fmt.Println("foo ",  i)
	}

	wg.Done()
}

func bar() {
	for i:=0; i<10; i++ {
		fmt.Println("bar ",i)
	}
}