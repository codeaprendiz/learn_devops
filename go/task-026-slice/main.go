package main

import "fmt"

func main() {
	x := []int{1,2,3,4,5}
	fmt.Println(x)

	for i, v := range x {
		fmt.Println(i,v)
	}

	fmt.Println(x[1:])

	fmt.Println("Appending to a slice")

	x = append(x, 6,7,8)

	fmt.Println(x)

	fmt.Println("Deleting from a slice")

	x = append(x[:2], x[3:]...)

	fmt.Println(x)

	fmt.Println("Using make to create a slice")

	sli := make([]int, 10, 100)
	fmt.Println("Slice length " , len(sli))
	fmt.Println("Slice capacity " , cap(sli))
	fmt.Println("Slice ", sli)

	// Multidimensional Slice

	firstStringArray := []string{"ank","rat"}
	secondStringArray := []string{"this","is","string"}
	multi := [][]string{firstStringArray ,secondStringArray}
	fmt.Println(multi)

}