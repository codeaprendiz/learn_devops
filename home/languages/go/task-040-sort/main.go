package main

import (
	"fmt"
	"sort"
)

func main() {
	x := []int{9,8,7,6,5,4,3,2,1}
	y := []string{"Abc","asdf","what is this", "programming"}

	fmt.Println(x)
	fmt.Println(y)

	fmt.Println("After sorting")
	sort.Ints(x)
	sort.Strings(y)
	fmt.Println(x)
	fmt.Println(y)


}