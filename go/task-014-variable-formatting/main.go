package main

import "fmt"

var a=10

func main() {
	for i := 60; i < 70; i++ {
		fmt.Printf("%d \t %b \t %x \t %q \n", i, i, i, i)
	}

	fmt.Println("Type of a is ", a)
	fmt.Printf("Type of a is %T ", a)
	fmt.Printf("\nBinary value a is %b ", a)
}
