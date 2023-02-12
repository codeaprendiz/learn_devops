package main

import "fmt"

// In this example, we've created a type Age as an alias for the built-in type int.
type Age int

func main() {
	var a int
	fmt.Printf("The type of a is %T\n", a)

	var a1 Age
	a1 = 12
	fmt.Printf("The type of a1 is %T\n", a1)
	fmt.Println("a1 = ", a1)

}
