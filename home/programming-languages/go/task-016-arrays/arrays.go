package main

import "fmt"

func main() {
	// Arrays
	var a [2]string
	a[0] = "Test"
	a[1] = "one"
	fmt.Println("Strings ", a[0], a[1], a)

	nums := [3]int{1, 2, 3}
	fmt.Println(nums)

	var slice_var []int = nums[0:2]
	fmt.Println(slice_var)

	names := [4]string{
		"ab",
		"cd",
		"ef",
		"gh",
	}

	// https://go.dev/tour/moretypes/7
	// The type []T is a slice with elements of type T.
	// A slice is formed by specifying two indices, a low and high bound, separated by a colon:
	// a[low : high]

	fmt.Println("names string is ", names)

	m := names[0:2]
	n := names[1:3]
	fmt.Println("m and n are : ", m, n)

	n[0] = "xxx"

	fmt.Println(m, n)
	fmt.Println(names)

	// A slice literal is like an array literal without the length.
	// This is an array literal: [3]bool{true, true, false}
	// And this creates the same array as above, then builds a slice that references it: []bool{true, true, false}

	r := []bool{false, true, false, false}
	fmt.Println(r)

	s := []struct {
		i int
		b bool
	}{
		{1, true},
		{2, false},
	}
	fmt.Println(s)

	// When slicing, you may omit the high or low bounds to use their defaults instead.
	// The default is zero for the low bound and the length of the slice for the high bound.
	sl := []int{0, 1, 2, 3, 4, 5, 6, 7, 8}

	sl1 := sl[1:2]
	sl2 := sl[1:]
	sl3 := sl[:2]
	fmt.Println(sl, sl1, sl2, sl3)

	new_slice := []int{0, 1, 2, 3, 4, 5}
	new_slice = new_slice[:0]
	print_slice(new_slice)

	new_slice = new_slice[:4]
	print_slice(new_slice)

	m1 := make([]int, 5)
	print_slice(m1)

	m2 := make([]int, 0, 10)
	print_slice(m2)

	// Appending to slice
	var ap []int
	print_slice(ap)

	ap = append(ap, 1)
	print_slice(ap)

	ap = append(ap, 3, 2, 4)
	print_slice(ap)

	var slice_two = []int{1, 2, 3, 4, 5, 6}
	for i, v := range slice_two {
		fmt.Println(i, v)
	}

	// omitting value
	for _, v1 := range slice_two {
		fmt.Println(" ", v1)
	}

}

func print_slice(s []int) {
	fmt.Printf("Len=%d and capacity= %d        slice %v\n", len(s), cap(s), s)
}
