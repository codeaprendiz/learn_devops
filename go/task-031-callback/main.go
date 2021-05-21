package main

import "fmt"

func main() {
	x := []int{1,2,3,4,5,6,7,8,9}
	fmt.Println("The sum of slice is " , sum(x...))
	s2 := even(sum, x...)
	fmt.Println("The sum of only even numbers is ", s2)

}

func sum(x ...int) int{
	fmt.Println("Passed : ", x)
	total := 0
	for _, v := range(x) {
		total+=v
	}
	return total
}

func even(f func(xi ...int) int, vi ...int) int{
	var yi []int
	for _, v := range vi {
		if v % 2 == 0 {
			yi = append(yi,v)
		}
	}
	return f(yi...)
}