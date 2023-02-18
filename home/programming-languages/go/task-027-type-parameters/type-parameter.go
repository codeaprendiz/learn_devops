package main

import "fmt"

/*
Go functions can be written to work on multiple types using type parameters. The type parameters of a function appear between brackets, before the function's arguments.

This is a Go program that defines a generic function Index and demonstrates its
usage with different types of slices. The Index function takes two arguments, a slice s of a generic type T and a value x of the same type T. It returns the index of the first occurrence of x in s, or -1 if x is not found.
*/
func Index[T comparable](s []T, x T) int {
	for i, v := range s {
		// v and x are type T, which has the comparable
		// constraint, so we can use == here.
		if v == x {
			return i
		}
	}
	return -1
}

func main() {
	// Index works on a slice of ints
	si := []int{1, 2, 3, 4, 5, 6}
	fmt.Println(si, 3)

	ss := []string{"aa", "bb", "cc", "dd"}
	fmt.Println(ss, "bb")
}
