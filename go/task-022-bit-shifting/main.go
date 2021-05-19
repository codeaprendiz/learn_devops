package main

import "fmt"

func main() {
	a := 2
	var b int
	b = a << 1
	fmt.Printf("a value is %d  and in binary %b", a ,a )
	fmt.Printf("\nb value is %d and in binary after bit shifting is %b", b ,b )
}