package main

import "fmt"

func main() {
	i, j := 23, 45
	p := &i
	q := &j
	fmt.Println("Value at p i.e. *p = ", *p)
	// Change the value at the address contained by q
	*q = 66
	fmt.Println("Now j should be equal to : ", j)
}
