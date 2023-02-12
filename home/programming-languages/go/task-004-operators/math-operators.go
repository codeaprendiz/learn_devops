package main

import "fmt"

func main() {
	// Addition and Subtraction
	fmt.Println(8 + 1)

	a := 2
	b := 5
	fmt.Println(a * b)

	values := []int{1, 2, 3, 4, 5, 6, 7}

	for _, x := range values {
		w := x
		fmt.Println("Before ", w)
		w *= 2
		fmt.Println("After", w)
	}
}
