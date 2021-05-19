package main

import "fmt"

func main() {
	var x int8
	x = -128
	fmt.Println(x)
	// The following line would result in integer overflow for int8 type
	// x = -129
	fmt.Println(x)
}