package main

import "fmt"

func main() {
	var arr [5]int
	arr[2]=24
	fmt.Println(arr[2])
	fmt.Println("Length of array is ", len(arr))
}