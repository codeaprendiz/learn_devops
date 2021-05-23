package main

import (
	"fmt"
	"runtime"
)

func main() {
	fmt.Println("OS ", runtime.GOOS)
	fmt.Println("Arch ", runtime.GOARCH)
	fmt.Println("CPUs ", runtime.NumCPU())
	fmt.Println("Go routines  ", runtime.NumGoroutine())

}