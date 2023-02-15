package main

import (
	"fmt"
)

func compute(fn func(int, int) int) int {
	return fn(2, 3)
}

func main() {
	myfunc := func(x, y int) int {
		return x + y
	}

	fmt.Println(myfunc(1, 2))
	fmt.Println(compute(myfunc))
}
