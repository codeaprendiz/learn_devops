package main

import "fmt"

// A function can take zero or more arguments.
func add(x int, y int) int {
	return x + y
}

// When two or more consecutive named function parameters share a type, you can omit the type from all but the last.
func add_v2(x, y int) int {
	return x + y
}

// A function can return any number of results.
func swap(x, y string) (string, string) {
	return y, x
}

func main() {
	fmt.Println("Result : ", add(2, 5))
	fmt.Println("Result from v2 : ", add(2, 7))
	a, b := swap("ab", "cd")
	fmt.Println("After swapping vars ", a, b)
}
