package main

import "fmt"

func main() {
	x := 2
	if x < 5 {
		fmt.Println("x is less than 5")
	}

	switch x {
	case 1:
		fmt.Println("I am one")
	case 2:
		fmt.Println("I am two")
	default:
		fmt.Println("I am default")
	}

}
